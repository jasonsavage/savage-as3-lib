package com.savage.utils
{
	
	/**
	 * The URLUtil class provides static methods for breaking down URLs.
	 * @author Jason Savage
	 * @see mx.utils.URLUtil
	 */
	public class URLUtil
	{
		/**
		 * Return the url with the query string removed. Default is the original url;
		 * @param	url
		 * @return
		 */
		public static function getURL(url:String):String
		{
			var s:Number = 0;
			var e:Number = url.indexOf("?");
			if (e == -1) e = url.length;
			
			return decodeURI(url.substring(s, e));
		}
		
		/**
		 * Return the filename (with extention) from the supplied url.
		 * @param	url
		 * @return
		 */
		public static function getFileName(url:String):String
		{
			url = URLUtil.getURL(url);
			url = url.substring(url.lastIndexOf("/")+1);
			if(url.indexOf(".") == -1) url = ""; //check for extention
			
			return url;
		}
		
		/**
		 * Return the channel from the supplied url (pesudo channel).
		 * @param	url
		 * @return
		 */
		public static function getChannel(url:String):String
		{
			url = URLUtil.getURL(url);
			url = url.substring(url.lastIndexOf("/")+1);
			if(url.indexOf(".") != -1) url = ""; //check for extention
			
			return url;
		}
		
		/**
		 * Return the file extention from the supplied url (removed "." and converts extention to uppercase).
		 * @param	url
		 * @return
		 */
		public static function getExtention(url:String):String
		{
			var n:String = URLUtil.getFileName(url);
			if(n == "") return "";
			
			var s:Number = (n.lastIndexOf(".")+1);
			return n.substring(s).toUpperCase();
		}
		
		/**
		 * Return the current directory from the supplied url.
		 * @param	url
		 * @return
		 */
		public static function getDirectory(url:String):String
		{
			url = URLUtil.getURL(url);
			
			if (url.substr( -1) == "/") 
				url = url.substr(0, url.length-1);
			
			var d:String = url.substring(0, url.lastIndexOf("/")+1);
			
			if(d.substr(-2) == "//" || d.substr(-2) == "::" || d.substr(-2) == ":/") d = "";
			
			return d;
		}
		
		/**
		 * Returns an object containing all the query variables from the supplied url. Default value is a new Object;
		 * @param	url
		 * @return
		 */
		public static function getParameters(url:String):Object
		{
			var s:Number = url.indexOf("?");
			if(s == -1) return {};
			var e:Number = url.indexOf("#");
			if(e == -1) e = url.length;
			var p:String = url.substring(s+1, e);
			
			var obj:Object = new Object();
			var arr:Array = p.split("&");
			while(arr.length)
			{
				var keyValue:Array = arr.shift().split(":");
				obj[ keyValue[0] ] = keyValue[1];
			}
			
			return obj;
		}
		
		/**
		 * Returns the anchor from the supplied url ("#" is removed).
		 * @param	url
		 * @return
		 */
		public static function getAnchor(url:String):String
		{
			return (url.indexOf("#") != -1) ? url.substr(url.indexOf("#")+1) : "";
		}
		
		/**
		 * Returns true or false if the url supplied has a host.
		 * @param	url
		 * @return
		 */
		public static function hasHost(url:String):Boolean
		{
			url = URLUtil.getURL(url);
			var pattern:RegExp = new RegExp("^[a-zA-Z]+(\:\/\/|\:\:)");
			
			return pattern.test(url);
		}
		
		/**
		 * Returns the protocol from the supplied url (uses <code>mx.utils.URLUtil.getProtocol()</code>)
		 * @param	url
		 * @return
		 */
		public static function getProtocol(url:String):String
		{
			if(!URLUtil.hasHost(url)) return "";
			url = URLUtil.getURL(url);
			
			return URLUtil.getProtocol(url);
		}
		
		/**
		 * Returns the host from the supplied url (uses <code>mx.utils.URLUtil.getServerName()</code>)
		 * @param	url
		 * @return
		 */
		public static function getHost(url:String):String
		{
			if(!URLUtil.hasHost(url)) return "";
			url = URLUtil.getURL(url);
			var h:String = URLUtil.getServerName(url);	
			if(h.split(".").length <= 2) h = "www." + h;
			
			return h;
		}
		
		/**
		 * Returns the domain from the supplied url.
		 * @param	url
		 * @return
		 */
		public static function getDomain(url:String):String
		{
			var h:String = URLUtil.getHost(url);
			if(h == "") return h;
			
			return h.substr(h.indexOf(".")+1); 
		}
		
		/**
		 * Returns the subDomain from the supplied url.
		 * @param	url
		 * @return
		 */
		public static function getSubDomain(url:String):String
		{
			var h:String = URLUtil.getHost(url);
			if(h == "") return h;
			
			return h.substr(0, h.indexOf("."));
		}
		
		/**
		 * Returns the topDomain from the supplied url.
		 * @param	url
		 * @return
		 */
		public static function getTopDomain(url:String):String
		{
			var h:String = URLUtil.getHost(url);
			if(h == "") return h;
			
			return h.substr(h.lastIndexOf(".")+1);
		}
		
		/**
		 * Returns the server name and port from the specified URL.
		 * @param	url
		 * @return
		 */
		public static function getServerNameWithPort(url:String):String
		{
			// Find first slash; second is +1, start 1 after.
			var start:int = url.indexOf("/") + 2;
			var length:int = url.indexOf("/", start);
			return length == -1 ? url.substring(start) : url.substring(start, length);
		}

		/**
		 *  Returns the server name from the specified URL.
		 *  
		 *  @param url The URL to analyze.
		 *  @return The server name of the specified URL.
		 */
		public static function getServerName(url:String):String
		{
			var sp:String = getServerNameWithPort(url);
			
			// If IPv6 is in use, start looking after the square bracket.
			var delim:int = sp.indexOf("]");
			delim = (delim > -1)? sp.indexOf(":", delim) : sp.indexOf(":");   
					 
			if (delim > 0)
				sp = sp.substring(0, delim);
			return sp;
		}

		/**
		 *  Returns the port number from the specified URL.
		 *  
		 *  @param url The URL to analyze.
		 *  @return The port number of the specified URL.
		 */
		public static function getPort(url:String):uint
		{
			var sp:String = URLUtil.getServerNameWithPort(url);
			
			// If IPv6 is in use, start looking after the square bracket.
			var delim:int = sp.indexOf("]");
			delim = (delim > -1)? sp.indexOf(":", delim) : sp.indexOf(":");          
			var port:uint = 0;
			if (delim > 0)
			{
				var p:Number = Number(sp.substring(delim + 1));
				if (!isNaN(p))
					port = int(p);
			}

			return port;
		}
	}
}