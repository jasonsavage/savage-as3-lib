package com.savage.model.vo 
{
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class DataProviderVO extends BasicVO 
	{
		public var label:String;
		public var data:String;
		
		/**
		 * Constructor
		 */
		public function DataProviderVO(xml:* = null, owner:Object = null) 
		{
			super(xml, owner);
		}
		
	}

}