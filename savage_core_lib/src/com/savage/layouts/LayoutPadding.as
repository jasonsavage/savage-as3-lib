package com.savage.layouts
{
	import flash.geom.Point;
	
	/**
	 * The LayoutPadding class ...
	 * @author jason.s
	 */
	public class LayoutPadding
	{
		private var _top:Number;
		private var _right:Number;
		private var _bottom:Number;
		private var _left:Number;
		
		
		/**
		 * Constructor
		 */
		public function LayoutPadding(top:Number=0, right:Number=0, bottom:Number=0, left:Number=0)
		{
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
		}
		
		public function get topLeft():Point
		{
			return new Point(_left, _top);
		}
		
		public function get top():Number { return _top; }
		public function set top(value:Number):void
		{
			_top = value;
		}
		
		public function get right():Number { return _top; }
		public function set right(value:Number):void
		{
			_right = value;
		}
		
		public function get bottom():Number { return _top; }
		public function set bottom(value:Number):void
		{
			_bottom = value;
		}
		
		public function get left():Number { return _top; }
		public function set left(value:Number):void
		{
			_left = value;
		}
		
	}
}