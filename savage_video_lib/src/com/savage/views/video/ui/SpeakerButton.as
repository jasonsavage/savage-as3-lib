package com.savage.views.video.ui 
{
	import com.savage.graphics.complex.SpeakerShape;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.IconButton;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SpeakerButton extends IconButton
	{
		/**
		 * Constructor
		 */
		public function SpeakerButton() 
		{
			super();
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			return new SpeakerShape(measureWidth() * 0.25, measureHeight() * 0.5, color);
		}
		
	}

}