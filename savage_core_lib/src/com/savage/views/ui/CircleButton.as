package com.savage.views.ui
{
	import com.savage.graphics.CircleShape;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.styles.LineStyle;
	import com.savage.views.IconButton;
	
	
	/**
	 * The CircleButton class ...
	 * @author jason.s
	 */
	public class CircleButton extends IconButton
	{
		/**
		 * Constructor
		 */
		public function CircleButton()
		{
			super();
			layout.setSize(15,15);
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			return new CircleShape(measureWidth(), measureHeight(), color);
		}
		
		
	}
}