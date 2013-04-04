package com.savage.managers 
{
	import com.savage.model.ApplicationProxy;
	import flash.utils.Dictionary;
	
	/**
	 * The ProxyManager class holds a reference to proxy classes that are used for loading and/or storing application data.
	 * @author Jason Savage
	 */
	public class ProxyManager 
	{
		private var _proxyMap:Dictionary;
		
		/**
		 * Constructor
		 */
		public function ProxyManager()
		{
			_proxyMap = new Dictionary();
		}
		
		/**
		 * Registers a proxy with the ProxyManager.
		 * @param	name
		 * @param	ProxyClass
		 */
		public function registerProxy( name:String, proxy:ApplicationProxy ):void
		{
			_proxyMap[ name ] = proxy;
		}
		
		/**
		 * Unregisters a proxy with the ProxyManager.
		 * @param	name
		 */
		public function unregisterProxy( name:String ) : void
		{
			_proxyMap[ name ] = null;
		}
		
		/**
		 * Returns the proxy under the supplied name from the ProxyManager.
		 * @param	name
		 */
		public function getProxy( name:String ):ApplicationProxy
		{
			return _proxyMap[ name ];
		}

	}

}