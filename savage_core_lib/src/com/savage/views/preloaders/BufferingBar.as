package com.savage.views.preloaders 
{
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.complex.LineGroup;
	import com.savage.graphics.styles.FillStyle;
	import com.savage.graphics.styles.LineStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.utils.MatrixUtil;
	import com.savage.views.View;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class BufferingBar extends View 
	{
		private var _lineColor:uint = 0x000000;
		private var _linesSkew:Number = -10;
		
		//children
		private var _lines:LineGroup;
		private var _linesMask:RectangleShape;
		
		/**
		 * Constructor
		 */
		public function BufferingBar() 
		{
			super();
			layout.width = 150;
			layout.height = 10;
			background = new SolidFillStyle(0xC0C0C0);
			cornerRadius = 10;
		}
		
		public function play():void
		{
			addEventListener(Event.ENTER_FRAME, on_EnterFrameHandler);
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, on_EnterFrameHandler);
		}
		
		protected function createLines():LineGroup
		{
			var w:Number = measureWidth();
			var h:Number = measureHeight();
			
			return new LineGroup(LineGroup.HORIZONTAL, w * 1.25, h, w * 0.1, 4, _lineColor);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add lines
			_lines = createLines();
			_lines.transform.matrix = MatrixUtil.skew(null, _linesSkew);
			addChild(_lines);
			
			//add lines mask
			_linesMask = new RectangleShape(measureWidth(), measureHeight(), 0, cornerRadius);
			addChild(_linesMask);
			
			_lines.mask = _linesMask;
		}
		
		private function on_EnterFrameHandler(event:Event):void
		{
			_lines.x++;
			
			if (_lines.x > 11)
				_lines.x = 0;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get lineColor():uint { return _lineColor; }
		public function set lineColor(value:uint):void
		{
			_lineColor = value;
			
			if(initialized)
				_lines.fillStyle = new SolidFillStyle(_lineColor);
		}
		
		public function get linesSkew():Number { return _linesSkew; }
		public function set linesSkew(value:Number):void
		{
			_linesSkew = value;
			
			if(initialized)
				_lines.transform.matrix = MatrixUtil.skew(null, _linesSkew);
		}
	}

}