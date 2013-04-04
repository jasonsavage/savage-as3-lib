package com.savage.styles
{
	
	/**
	 * The SpeakerVolumeBarsStyle class ...
	 * @author jason.s
	 */
	public class SpeakerVolumeBarsStyle
	{
		public var lineColor:uint;
		public var backgroundLineColor:uint;
		
		/**
		 * Constructor
		 */
		public function SpeakerVolumeBarsStyle(lineColor:uint=0xDB5823, backgroundLineColor:uint=0x999999)
		{
			this.lineColor = lineColor;
			this.backgroundLineColor = backgroundLineColor;
		}
	}
}