package com.savage.utils
{
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class BrowserUtil
	{
		
		public static const FIREFOX:String = "firefox";
		public static const IE:String = "msie";
		public static const SAFARI:String = "safari";
		public static const CHROME:String = "chrome";
		
		/**
		 * Redirects the browser to the specified url.
		 * @param	url
		 * @param	inNewWindow
		 */
		public static function redirect(url:String="#", inNewWindow:Boolean=false):void
		{
			if(url != "#" && url != "" && url.charAt(0) != "#")
			{
				var win:String = (inNewWindow)? "_blank" : "_self";
				navigateToURL( new URLRequest(url), win);
			}
		}
		
		/**
		 * Executes a javascript method on the parent webpage.
		 * @param	methodName
		 * @param	...args
		 */
		public static function executeJavaScript(methodName:String, ...args):void
		{
			if (methodName == "") return;
			
			if (ExternalInterface.available) 
			{
				try
				{
					if (args.length == 0)
					{
						ExternalInterface.call(methodName);
					}
					else
					{
						args.splice(0, 0, methodName);
						ExternalInterface.call.apply(null, args);
					}
				}
				catch (e:Error)
				{
					throw new Error("Unable to communicate to the parent webpage.");
				}
			}
			else
			{
				throw new Error("ExternalInterface API not available.");
			}
		}
		
		
		public static function getHash():String
		{
			try
			{
				return ExternalInterface.call("function() {return location.hash;}").toString();
			}
			catch (e:Error) { }
			return "";
		}
		
		public static function getHost():String
		{
			try
			{
				return ExternalInterface.call("function() {return location.host;}").toString();
			}
			catch (e:Error) { }
			return "";
		}
		
		public static function getPathname():String
		{
			try
			{
				return ExternalInterface.call("function() {return location.pathname;}").toString();
			}
			catch (e:Error) { }
			return "";
		}
		
		public static function getBrowser():String
		{
			try
			{
				var b:String = ExternalInterface.call("function() {return navigator.userAgent;}").toString();
				if (b)
				{
					b = b.toLowerCase();
					
					if ( b.indexOf(CHROME) != -1 )
						return CHROME;
					if ( b.indexOf(FIREFOX) != -1)
						return FIREFOX;
					if ( b.indexOf(SAFARI) != -1 )
						return SAFARI;
					if ( b.indexOf(IE) != -1 )
						return IE;
					return b;
				}
			}
			catch (e:Error) { }
			return "";
		}
	}
}