package com.savage.model.vo 
{
	/**
	 * <a id="" href="" target="_blank" />
	 * @author Jason Savage
	 */
	public class HyperLinkVO extends BasicVO 
	{
		public var id:String = "";
		public var href:String = "";
		public var target:String = "_self";
		
		/**
		 * Constructor
		 */
		public function HyperLinkVO(xml:* = null, owner:Object = null) 
		{
			super(xml, owner);
		}
		
	}

}