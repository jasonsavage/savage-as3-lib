package com.savage.views.scroll 
{
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.complex.LineGroup;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.ButtonBase;
	import com.savage.views.IconButton;
	import com.savage.views.View;

	
	/**
	 * ...
	 * @author ...
	 */
	public class ThumbButton extends IconButton 
	{
		/**
		 * Constructor
		 */
		public function ThumbButton(width:Number=16, height:Number=32) 
		{
			super();
			layout.setSize(width, height);
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			return new LineGroup(LineGroup.VERTICAL, 8, 10, 3, 1, 0xFFFFFF);
		}
	}

}