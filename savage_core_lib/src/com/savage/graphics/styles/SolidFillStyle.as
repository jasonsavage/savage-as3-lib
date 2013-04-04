package com.savage.graphics.styles
{
	import flash.display.Graphics;
	
	/**
	 * The FillStyle class ...
	 * @author jason.s
	 */
	public class SolidFillStyle extends FillStyle
	{
		private var _color:uint;
		private var _alpha:Number;
		
		/**
		 * Constructor
		 */
		public function SolidFillStyle(color:uint=0, alpha:Number=1)
		{
			super();
			_color = color;
			_alpha = alpha;
		}
		
		override public function applyFill(graphics:Graphics):void
		{
			graphics.beginFill(_color, _alpha);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}
	}
}