package com.savage.views.scroll 
{
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.TriangleShape;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.ButtonBase;
	import com.savage.views.IconButton;
	import com.savage.views.View;
	
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ArrowButton extends IconButton
	{
		private var _direction:int;
		
		/**
		 * Constructor
		 */
		public function ArrowButton(direction:int=1) 
		{
			super();
			_direction = direction;
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			var shape:TriangleShape = new TriangleShape(measureHeight()*0.5, measureWidth()*0.5, color, true);
			shape.rotation = _direction * 90;
			return shape;
		}
	}

}