package com.savage.core
{
	import com.savage.interfaces.IFacadeTestData;
	import com.savage.interfaces.INoteSubscriber;
	import com.savage.managers.NotificationManager;
	import com.savage.managers.ProxyManager;
	import com.savage.model.ApplicationProxy;
	import com.savage.model.ConfigProxy;
	import com.savage.model.FlashVarsProxy;
	import com.savage.model.HyperLinkProxy;
	import com.savage.model.vo.HyperLinkVO;
	import com.savage.utils.BrowserUtil;
	
	public class ApplicationFacade
	{
		public static var CONTENT_SWF_KEY:String = "CONTENT_SWF_URL";
		
		private static const ERROR_SINGLETON:String = "ApplicationFacade is a singleton class and cannot be directly instantiated, Use AppInterface.getInstance() instead.";
		private static const ERROR_APP_NOT_INIT:String = "ApplicationBase has not been inialized.";
		private static const ERROR_APP_SINGLETON:String = "Only one instance of ApplicationBase can be instantiated.";
		
		/**************************************
		 * Properties
		 **************************************/
		private var _proxyManager:ProxyManager;
		private var _notesManager:NotificationManager;
		
		/**
		 * Contructor
		 * @param	baseMovieClip
		 */
		public function ApplicationFacade(e:SingletonEnforcer) 
		{
			//init Managers
			_proxyManager = new ProxyManager();
			_notesManager = new NotificationManager();
		}
		
		/**
		 * Gets the content swf url that will be loaded by the ApplicationBase
		 * @return
		 */
		public function getContentSwfURL():String
		{
			var url:String = getAppSetting(CONTENT_SWF_KEY) as String;
			return resolveAssetsPath(url);
		}
		
		/**
		 * If a swfconfig.xml file was used, this returns the 
		 * value under under the appsettings node specified by <code>name</code>.
		 * @param	name
		 * @return
		 */
		public function getAppSetting(key:String):Object
		{
			var proxy:ConfigProxy = getProxy(ConfigProxy.NAME) as ConfigProxy;
			return proxy.getValue(key);
		}
		
		/**
		 * Returns the FlashVars value supplied to flash specified by <code>name</code>.
		 * @param	name
		 * @return
		 */
		public function getFlashVars(name:String, suppressError:Boolean=false):String
		{
			var proxy:FlashVarsProxy = getProxy(FlashVarsProxy.NAME) as FlashVarsProxy;
			
			if (!proxy || !proxy.hasValue(name) )
			{
				if (!suppressError)
					throw new ArgumentError("The FlashVars \"" + name + "\" was not found.");
				else
					return "";
			}
			
			return proxy.getValue(name) as String;
		}
		
		/**
		 * Returns the path to the assets folder.
		 * @param	url
		 * @return
		 */
		public function resolveAssetsPath(url:String):String
		{
			if (url.charAt(0) == "/")
				url = url.substr(1);
				
			var proxy:FlashVarsProxy = getProxy(FlashVarsProxy.NAME) as FlashVarsProxy;
			
			if( proxy )
				return proxy.resolveAssetsPath(url);
			
			return "assets/" + url;
		}
		
		/**
		 * Redirects the browser to a new url or opens in a new window.
		 * Use "#" to reference a hyperlink in the swfconfig.xml
		 * @param	url
		 * @param	inNewWindow
		 * @return
		 */
		public function redirect(url:String, inNewWindow:Boolean=false):void
		{
			if (url.charAt(0) == "#" && url.length > 1)
			{
				var facade:ApplicationFacade = ApplicationFacade.getInstance();
				var proxy:HyperLinkProxy = facade.getProxy(HyperLinkProxy.NAME) as HyperLinkProxy;
				
				if (proxy)
				{
					var data:HyperLinkVO = proxy.getValue( url.substr(1) ) as HyperLinkVO;
					url 		= data.href;
					inNewWindow = (data.target == "_blank");
				}
			}
			
			BrowserUtil.redirect(url, inNewWindow);
		}
		
		/**************************************
		 * Facade Notification Methods
		 **************************************/
		//{
		 
		/**
		 * Sends out a notification through the NotificationManager.
		 * @param	notificationName
		 * @param	body
		 */
		public function sendNotification( name:String, body:Object=null):void 
		{
			_notesManager.sendNotification(name, body);
		}
		
		/**
		 * Subscribes the supplied INoteSubscriber to notifications sent through the NotificationManager.
		 * @param	subscriber
		 */
		public function subscribe(subscriber:INoteSubscriber):void
		{
			_notesManager.subscribe(subscriber);
		}
		
		/**
		 * Unsubscribes the supplied INoteSubscriber from notifications sent through the NotificationManager.
		 * @param	subscriber
		 */
		public function unsubscribe(subscriber:INoteSubscriber):void
		{
			_notesManager.unsubscribe(subscriber);
		}
		//}
		
		/**************************************
		 * Facade Proxy Methods
		 **************************************/
		//{
		/**
		 * Registers an ApplicationProxy with the facade.
		 * @param	proxyName
		 * @param	proxy
		 * @return
		 */
		public function registerProxy(proxyName:String, proxy:ApplicationProxy):ApplicationProxy
		{
			_proxyManager.registerProxy(proxyName, proxy);
			return proxy;
		}
		
		/**
		 * Unregisters an ApplicationProxy with the facade.
		 * @param	proxyName
		 */
		public function unregisterProxy(proxyName:String):void
		{
			_proxyManager.unregisterProxy(proxyName);
		}
		
		/**
		 * Returns the ApplicationProxy under the supplied proxyName.
		 * @param	proxyName
		 * @return
		 */
		public function getProxy(proxyName:String):ApplicationProxy
		{
			return _proxyManager.getProxy( proxyName );
		}
		//}
		
		/**************************************
		 * Static
		 **************************************/
		
		private static var _instance:ApplicationFacade;
		
		/**
		 * Get a reference to the current project's AppInterface
		 * @return
		 */
		public static function getInstance():ApplicationFacade
		{
			if (!_instance)
				_instance = new ApplicationFacade( new SingletonEnforcer() );
			
			return _instance;
		}
		
		public static function runInTestMode( data:IFacadeTestData ):void
		{
			trace("*******************************");
			trace("* Facade running in test mode *");
			trace("*******************************");
			
			var facade:ApplicationFacade = getInstance();
			facade.registerProxy( FlashVarsProxy.NAME, new FlashVarsProxy(data.getFlashVars()) );
			facade.registerProxy( ConfigProxy.NAME, new ConfigProxy(data.getAppSettingsXML()) );
		}
	}
}
class SingletonEnforcer { };