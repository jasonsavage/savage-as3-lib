package com.savage.styles
{
	
	/**
	 * The PushButtonStyle class ...
	 * @author jason.s
	 */
	public class PushButtonStyle extends ButtonStyle
	{
		public var selectedColor:uint;
		
		/**
		 * Constructor
		 */
		public function PushButtonStyle(upColor:uint=0x000000, overColor:uint=0xDB5823, downColor:uint=0x000000, selectedColor:uint=0xDB5823)
		{
			super(upColor, overColor, downColor);
			this.selectedColor = selectedColor;
		}
	}
}