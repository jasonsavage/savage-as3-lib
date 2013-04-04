package com.savage.views 
{
	import com.savage.graphics.complex.LineGroup;
	import com.savage.graphics.styles.GradientFillStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.utils.LayoutUtil;
	import com.savage.utils.MathUtil;
	import com.savage.views.View;
	import com.savage.views.ui.CircleButton;
	
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * The SliderView is a basic horizontal slider with a track and a thumb and tick marks. 
	 * 
	 * @author Jason Savage
	 */
	public class SliderView extends View 
	{
		private var _thumbOffset:Number;
		private var _thumbMax:Number;
		private var _tickInterval:int = 3;
		private var _snapInterval:int = 3;
		private var _value:Number = 0;
		
		//children
		private var _track:View;
		private var _thumb:View;
		private var _ticks:LineGroup;
		
		/**
		 * Constructor
		 */
		public function SliderView() 
		{
			super();
			layout.width = 100;
			layout.height = 16;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbBtn_DownHandler);
			_thumbMax = measureWidth() - _thumb.measureWidth();
			updateTickMarks();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//ticks
			_ticks = createTickMarks();
			addChild(_ticks);
			
			//track
			_track = createTrack();
			LayoutUtil.centerVertInView(this, _track);
			addChild(_track);

			//thumb
			_thumb = createThumb();
			LayoutUtil.centerVertInView(this, _thumb);
			_thumb.buttonMode = true;
			addChild(_thumb);
		}
		
		protected function createTrack():View
		{
			var view:View = new View();
			view.background = new GradientFillStyle(GradientType.LINEAR, [0xA89BA8, 0xC6BDC6], [1, 1]);
			view.layout.height = measureHeight() * 0.5;
			view.layout.width = measureWidth();
			view.cornerRadius = Number(view.layout.height);
			
			return view;
		}
		
		protected function createTickMarks():LineGroup
		{
			return new LineGroup(LineGroup.HORIZONTAL, measureWidth()-3, 4, 3, 1);
		}
		
		protected function createThumb():View
		{
			return new CircleButton();
		}
		
		protected function updateThumbPos():void
		{
			if(initialized)
				_thumb.x = _value * _thumbMax;
		}
		
		protected function snapPercent(value:Number):Number
		{
			var snap:Number = 0;
			var increments:Number = 1 / (_snapInterval - 1);
			
			while (snap < value)
			{
				if(snap + (increments * 0.5) > value)
					break;
					
				snap += increments;
			}
			return snap;
		}
		
		protected function updateTickMarks():void
		{
			var count:Number = _tickInterval-1;
			var w:Number = measureWidth();
			
			_ticks.amount = count;
			//_ticks.gap = Math.floor(w / count) - count;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		protected function onThumbBtn_DownHandler(event:MouseEvent):void
		{
			_thumbOffset = _thumb.mouseX;
			
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onThumbBtn_DownHandler);
			_thumb.addEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouse_MoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
		}
		
		protected function onThumbBtn_UpHandler(event:MouseEvent):void
		{
			_thumbOffset = 0;
			
			_thumb.removeEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbBtn_DownHandler);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouse_MoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onThumbBtn_UpHandler);
			
			//set value
			value = (_thumb.x / _thumbMax);
		}
		
		protected function onMouse_MoveHandler(event:MouseEvent):void
		{
			var nextX:Number = mouseX - _thumbOffset;
			nextX = MathUtil.limit(nextX, 0, _thumbMax);
			
			//_thumb.x = nextX;
			value = (nextX / _thumbMax);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get tickInterval():int { return _tickInterval; }
		public function set tickInterval(value:int):void
		{
			_tickInterval = value;
			updateTickMarks();
		}
		
		public function get snapInterval():Number { return _snapInterval; }
		public function set snapInterval(value:Number):void
		{
			_snapInterval = value;
			updateThumbPos();
		}
		
		public function get value():Number { return _value; }
		public function set value(value:Number):void
		{
			var perc:Number = snapPercent( MathUtil.limit(value, 0, 1) );
			if (perc == _value) return;
			
			_value = perc;
		
			updateThumbPos();
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}