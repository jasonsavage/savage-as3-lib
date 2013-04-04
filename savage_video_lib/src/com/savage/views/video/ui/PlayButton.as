package com.savage.views.video.ui 
{
	import com.savage.graphics.TriangleShape;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.IconButton;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PlayButton extends IconButton
	{
		
		/**
		 * Constructor
		 */
		public function PlayButton() 
		{
			super();
		}

		override protected function createIcon(color:uint):DrawnShape
		{
			return new TriangleShape(measureWidth() * 0.4, measureWidth() * 0.4, color);
		}
	}

}