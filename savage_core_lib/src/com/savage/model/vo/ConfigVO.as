package com.savage.model.vo 
{
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ConfigVO extends BasicVO 
	{
		public var key:String = "";
		public var type:String = "";
		public var value:String = "";
		
		/**
		 * Constructor
		 */
		public function ConfigVO(xml:* = null, owner:Object = null) 
		{
			super(null, owner);
			
			key = xml.@key.toString();
			type = xml.@type.toString();
			value = xml.@value.toString();
			
			if (value == "")
				value = xml.toString();
		}
		
		public function getDataTypeValue():Object
		{
			switch(type)
			{
				case "XMLList" :
					return new XMLList(value);
				break;
					
				case "Boolean" :
					return (value == "true");
				break;
					
				case "Number" :
					return parseFloat(value);
				break;
					
				case "String" :
					return value.toString();
				break;
			}
			return null;
		}
	}

}