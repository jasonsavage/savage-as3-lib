package com.savage.views.video.ui 
{
	import com.savage.graphics.complex.ExpandIcon;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.IconButton;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ExpandButton extends IconButton
	{
		/**
		 * Constructor
		 */
		public function ExpandButton() 
		{
			super();
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			return new ExpandIcon(10, 10, color);
		}
		
		
	}

}