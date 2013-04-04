package com.savage.views.video.ui 
{
	import com.savage.graphics.complex.LineGroup;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.IconButton;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PauseButton extends IconButton
	{
		/**
		 * Constructor
		 */
		public function PauseButton() 
		{
			super();
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			var w:Number = measureWidth();
			var h:Number = measureHeight();
			return new LineGroup(LineGroup.HORIZONTAL, w * 0.3, h * 0.4, 2, w * 0.1, color);
		}

	}

}