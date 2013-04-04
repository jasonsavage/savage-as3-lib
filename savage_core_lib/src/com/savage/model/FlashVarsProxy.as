package com.savage.model 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public final class FlashVarsProxy extends ApplicationProxy
	{
		public static const NAME:String = "FlashVarsProxy";
		
		/**
		 * Constructor
		 */
		public function FlashVarsProxy(parameters:Object) 
		{
			super(parameters);
		}
		
		public function resolveAssetsPath(url:String):String
		{
			if( hasValue("ap") )
				return getValue("ap") + url;
				
			return "assets/" + url;
		}
	}
}