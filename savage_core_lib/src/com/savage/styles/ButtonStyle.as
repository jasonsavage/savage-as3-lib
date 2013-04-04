package com.savage.styles
{
	
	/**
	 * The ButtonStyle class ...
	 * @author jason.s
	 */
	public class ButtonStyle
	{
		public var upColor:uint = 0x000000;
		public var overColor:uint = 0xDB5823;
		public var downColor:uint = 0x000000;
		
		/**
		 * Constructor
		 */
		public function ButtonStyle(upColor:uint=0x000000, overColor:uint=0xDB5823, downColor:uint=0x000000)
		{
			this.upColor = upColor;
			this.overColor = overColor;
			this.downColor = downColor;
		}
	}
}