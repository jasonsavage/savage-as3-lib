package com.savage.graphics.core 
{
	import com.savage.graphics.styles.FillStyle;
	import com.savage.graphics.styles.LineStyle;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SolidShape extends DrawnShape 
	{
		private var _lineStyle:LineStyle;
		private var _fillStyle:FillStyle;
		
		/**
		 * Constructor
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	center
		 */
		public function SolidShape(width:Number = 10, height:Number = 10, fillStyle:FillStyle=null, lineStyle:LineStyle=null) 
		{
			super(width, height);
			_lineStyle = lineStyle;
			_fillStyle = fillStyle;
		}
		
		override protected function beginDraw():void 
		{
			super.beginDraw();
			
			graphics.clear();
			
			if (_fillStyle)
				_fillStyle.applyFill(graphics);
			
			if (_lineStyle)
				_lineStyle.applyLine(graphics);
		}
		
		override protected function endDraw():void 
		{
			super.endDraw();
			graphics.endFill();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get lineStyle():LineStyle { return _lineStyle; }
		public function set lineStyle(value:LineStyle):void
		{
			_lineStyle = value;
			invalidateProperties();
		}
		
		public function get fillStyle():FillStyle { return _fillStyle; }
		public function set fillStyle(value:FillStyle):void
		{
			_fillStyle = value;
			invalidateProperties();
		}
	}

}