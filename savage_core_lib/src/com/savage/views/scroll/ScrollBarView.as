package com.savage.views.scroll
{
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.interfaces.IMeasurable;
	import com.savage.utils.LayoutUtil;
	import com.savage.utils.MathUtil;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	/**
	 * The ScrollBarView is a basic vertical scrollbar that consists of two arrow buttons, 
	 * a track between them, and a variable-size scroll thumb.
	 */
	public class ScrollBarView extends View
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _sourceMax:Number;
		private var _thumbOffset:Number;
		private var _autoSizeToSource:Boolean;
		
		private var _sourceMaxPad:Number = 0;
		private var _velocity:Number = 0;
		private var _friction:Number = 0.75;
		private var _last:Number;
		private var _property:String;
		
		private var _lastScrollPoint:Number = 0;
		private var _scrollTimeCount:Number = 1;
		private var _scrollTimeMax:int = 20;
		
		private var _isArrowADown:Boolean;
		private var _isArrowBDown:Boolean;
		private var _isThumbDown:Boolean;
		private var _scrolling:Boolean;
		
		private var _lineScrollSize:Number = 1;
		
		private var _source:DisplayObject;
		private var _scrollDirection:String;
		private var _useMeasurements:Boolean;
		
		//children
		private var _arrowA:View;
		private var _arrowB:View;
		private var _thumb:View;
		
		
		/**
		 * Constructor
		 */
		public function ScrollBarView(scrollDirection:String="vertical")
		{
			super();
			
			_scrollDirection = scrollDirection;
			_property = (_scrollDirection == HORIZONTAL)? "x" : "y";
			
			//default
			layout.width = 16;
			layout.height = 200;
			background = new SolidFillStyle(0xd1d1d1);
		}
		
		protected function createArrowAView():View
		{
			return new ArrowButton(3);
		}
		
		protected function createArrowBView():View
		{
			return new ArrowButton(1);
		}
		
		protected function createThumbView(size:Number):View
		{
			return new ThumbButton(measureWidth(), size);
		}
		
		/**************************************
		 * Private / Protected
		 **************************************/
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_arrowA.addEventListener(MouseEvent.MOUSE_DOWN, onArrowA_MouseDownHandler);	
			_arrowA.addEventListener(MouseEvent.MOUSE_UP, onArrowAB_MouseUpHandler);	
			
			_arrowB.addEventListener(MouseEvent.MOUSE_DOWN, onArrowB_MouseDownHandler);
			_arrowB.addEventListener(MouseEvent.MOUSE_UP, onArrowAB_MouseUpHandler);	

		}
		
		protected function addThumbView():void
		{
			if (_thumb)
			{
				removeChild(_thumb);
				_thumb = null;
			}
			
			//add new thumb
			if (_scrollDirection == HORIZONTAL)
				_thumb = createThumbView( (_source.scrollRect.width / _source.width) * thumbMaxSize  );
			else
				_thumb = createThumbView( (_source.scrollRect.height / _source.height) * thumbMaxSize  );
				
			addChild(_thumb);
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbBtn_DownHandler);
			thumbPos = thumbMin;
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add first arrow
			_arrowA = createArrowAView();
			_arrowA.top = 0;
			addChild(_arrowA);
			
			//add last arrow
			_arrowB = createArrowBView();
			_arrowB.bottom = 0;
			addChild(_arrowB);
		}
		
		private function stopScroll():void
		{
			_scrolling = false;
			removeEventListener(Event.ENTER_FRAME, updateScollPosition);
			
			if(_thumb && contains(_thumb) )
				removeChild( _thumb );
		}
		
		private function startScroll():void
		{
			if (_scrollDirection == HORIZONTAL)
			{
				if (_useMeasurements && _source is IMeasurable)
					_sourceMax = IMeasurable(_source).measureWidth() - _source.scrollRect.width;
				else
					_sourceMax = _source.width - _source.scrollRect.width;
			}
			else
			{
				if (_useMeasurements && _source is IMeasurable)
					_sourceMax = IMeasurable(_source).measureHeight() - _source.scrollRect.height;
				else
					_sourceMax = _source.height - _source.scrollRect.height;
			}
			
			_sourceMax += _sourceMaxPad;
			
			if (!_scrolling)
			{
				_scrolling = true;
				addEventListener(Event.ENTER_FRAME, updateScollPosition);
			}
			
			addThumbView();
		}
		
		private function validateScroll():Boolean
		{
			if (!_source)
				return false;
				
			return ScrollBarView.validateScroll(_source, _scrollDirection);
		}
		
		public static function validateScroll(view:DisplayObject, direction:String="vertical"):Boolean
		{
			if (!view.scrollRect)
				return false;
				
			if (direction == HORIZONTAL && view.scrollRect.width >= view.width)
				return false;
				
			if (direction == VERTICAL && view.scrollRect.height >= view.height)
				return false;
				
			return true;
		}
		
		override public function updateProperties():void
		{
			super.updateProperties();
			
			if(_source && _autoSizeToSource)
			{
				layout.height = (_scrollDirection == HORIZONTAL) ? LayoutUtil.measureObjectWidth(source) : LayoutUtil.measureObjectHeight(source);
			}
		}
		
		override public function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			if( !validateScroll() )
			{
				stopScroll();
			}
			else
			{
				if(!_scrolling)
				{
					startScroll();
				}
			}
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		private function updateScollPosition(event:Event):void
		{
			var next:Number;
			
			if (_isThumbDown)
			{
				_velocity = thumbPos - _last;
				_velocity = MathUtil.limit(_velocity, -16, 16);
				_last = thumbPos;
			}
			else if (_isArrowADown)
			{
				next = thumbPos - _lineScrollSize;
				thumbPos = MathUtil.limit(next, thumbMin, thumbMax);
			}
			else if (_isArrowBDown)
			{
				next = thumbPos + _lineScrollSize;
				thumbPos = MathUtil.limit(next, thumbMin, thumbMax);
			}
			else
			{
				next = thumbPos + _velocity;
				
				//bounce
				if (next > thumbMax)
				{
					next = thumbMax;
					_velocity *= -1;
				}
				if (next < thumbMin)
				{
					next = thumbMin;
					_velocity *= -1;
				}
				
				thumbPos = next;
				_velocity *= _friction;
			}
			
			//update source
			var percY:Number = (thumbPos - thumbMin) / (thumbMax - thumbMin);
			
			next = percY * _sourceMax;
			
			if (next == _lastScrollPoint) //if no change then increase _scrollTimeCount towards _scrollTimeMax
				_scrollTimeCount = (_scrollTimeCount < _scrollTimeMax) ? _scrollTimeCount + 0.3 : _scrollTimeMax;
			else
				_scrollTimeCount = 1;
			
			sourcePos = RegularEaseOut(_scrollTimeCount, sourcePos, next - sourcePos, _scrollTimeMax);
			_lastScrollPoint = next;
		}
		
		/**
		 * The <code>easeOut()</code> method starts motion fast 
		 * and then decelerates motion to a zero velocity as it executes.      
		 */  
		private function RegularEaseOut(t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * (t /= d) * (t - 2) + b;
		}
		
		protected function onThumbBtn_DownHandler(event:MouseEvent):void
		{
			if (!_scrolling) return;
			
			_thumbOffset = _thumb.mouseY;
			
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onThumbBtn_DownHandler);
			_thumb.addEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouse_MoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			
			_isThumbDown = true;
		}
		
		protected function onThumbBtn_UpHandler(event:MouseEvent):void
		{
			if (!_scrolling) return;
			
			_thumbOffset = 0;
			
			_thumb.removeEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbBtn_DownHandler);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouse_MoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			
			_isThumbDown = false;
		}
		
		protected function onMouse_MoveHandler(event:MouseEvent):void
		{
			thumbPos = MathUtil.limit(mousePos, thumbMin, thumbMax);
		}
		
		protected function onArrowA_MouseDownHandler(event:MouseEvent):void
		{
			_isArrowADown = true;
		}
		
		protected function onArrowB_MouseDownHandler(event:MouseEvent):void
		{
			_isArrowBDown = true;
		}
		
		protected function onArrowAB_MouseUpHandler(event:MouseEvent):void
		{
			_isArrowADown = _isArrowBDown = false;
		}
		
		/**************************************
		 * Private Accessors
		 **************************************/
		
		private function get thumbMaxSize():Number
		{
			return measureHeight() - _arrowA.measureHeight()  - _arrowB.measureHeight();
		}
		 
		private function get thumbMin():Number 
		{ 
			return _arrowA.measureHeight();
		}
		
		private function get thumbMax():Number 
		{ 
			return measureHeight() - _arrowB.measureHeight()  - _thumb.measureHeight();
		}
		
		private function get thumbPos():Number 
		{ 
			return _thumb.y;
		}
		
		private function set thumbPos(value:Number):void
		{
			_thumb.y = value;
		}
		
		private function get sourcePos():Number 
		{ 
			return _source.scrollRect[_property];
		}
		
		private function set sourcePos(value:Number):void
		{
			var rect:Rectangle = _source.scrollRect;
			rect[_property] = value;
			_source.scrollRect = rect;
		}
		
		private function get mousePos():Number 
		{ 
			return (mouseY - _thumbOffset);
		}
		
		/**************************************
		 * Public Accessors
		 **************************************/
		 
		public function get lineScrollSize():int { return _lineScrollSize; }
		public function set lineScrollSize(value:int):void
		{
			_lineScrollSize = value;
		}
		
		public function get friction():Number { return _friction; }
		public function set friction(value:Number):void
		{
			_friction = value;
		}
		
		public function get sourceMaxPad():Number { return _sourceMaxPad; }
		public function set sourceMaxPad(value:Number):void
		{
			_sourceMaxPad = value;
		}
		
		public function get value():Number { return (thumbPos - thumbMin) / (thumbMax - thumbMin); }
		public function set value(value:Number):void
		{
			value = MathUtil.limit(value, 0, 1);
			thumbPos = thumbMin + (value * (thumbMax - thumbMin));
		}
		
		public function get autoSizeToSource():Boolean { return _autoSizeToSource; }
		public function set autoSizeToSource(value:Boolean):void
		{
			_autoSizeToSource = value;
			invalidateProperties();
		}
		
		public function get source():DisplayObject { return _source; }
		public function set source(value:DisplayObject):void
		{
			_source = value;
			invalidateProperties();
			invalidateDisplayList();
		}
		
		public function get useMeasurements():Boolean { return _useMeasurements; }
		public function set useMeasurements(value:Boolean):void
		{
			_useMeasurements = value;
		}
	}

}