package com.savage.model
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Capabilities;
	
	/** 
	 *  Dispatched when all the data has been loaded and processed successfully.
	 *
	 *  @eventType flash.events.Event.COMPLETE 
	 */
	[Event(name = "complete", type = "flash.events.Event")]
	
	/** 
	 *  Dispatched during the load.
	 *
	 *  @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	
	/** 
	 *  Dispatched when the load request fails.
	 *
	 *  @eventType flash.events.ErrorEvent.ERROR
	 */
	[Event(name = "error", type = "flash.events.ErrorEvent")]
	
	/**
	 * The LoaderProxy class ...
	 * @author jason.s
	 */
	public class URLLoaderProxy extends ApplicationProxy
	{

		protected var _success:Boolean;
		private var _url:String;
		private var _suppressError:Boolean;
		
		private var _loader:URLLoader;
		private var _request:URLRequest;
		
		
		/**
		 * Constructor
		 */
		public function URLLoaderProxy(data:Object=null)
		{
			super();
			
			//create loader
			_loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoader_SuccessHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, onLoader_ProgressHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoader_ErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoader_ErrorHandler);
			
			//apply data
			if(data)
				proccessResult(data as String);
		}
		
		/**
		 * Loads the data.
		 * @param	params
		 * @param	requestMethod
		 */
		public function load(params:Object=null, requestMethod:String="GET" ):void
		{
			if ( _url.length == 0)
				throw new ArgumentError("No url specified.");
			
			//clear old data
			unload();
			
			//create request
			_request = new URLRequest( _url );
			_request.method = requestMethod;
			
			//kill cache
			if(Capabilities.playerType != "External")
			{
				if(!params) params = {};
				params.requestId = Math.floor(Math.random() * 100000);
			}
			
			if(params)
				_request.data = getUrlVariables(params);
			
			//load data from url
			_loader.load(_request);
		}
		
		/**
		 * Clears out old data.
		 */
		public function unload():void
		{
			_success = false;
			_request = null;
			_loader.data = null;
		}
		
		
		/**
		 * Called after load completes successfully to process the loaded content.
		 */
		protected function proccessResult(content:String):void 
		{
			_data = content;
		}
		
		
		/**************************************
		 * Private
		 **************************************/
		
		private function getUrlVariables(params:Object):URLVariables 
		{
			var variables:URLVariables = new URLVariables(); 
			for (var key:String in params)
				variables[key] = params[key];
			
			return variables;
		}
		
		
		/**************************************
		 * Handlers
		 **************************************/
		
		protected function onLoader_SuccessHandler(event:Event):void
		{
			_success = true;
			proccessResult( _loader.data.toString() );
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function onLoader_ErrorHandler(event:Event):void
		{
			_success = false;
			
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
			
			trace(event.toString());
			
			if (!_suppressError)
				throw new Error(this + " was unable to finish the request to " + _url );
		}
		
		protected function onLoader_ProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent( event.clone() );
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		protected function get loader():EventDispatcher { return _loader; }
		
		public function get success():Boolean { return _success; }
		
		public function get url():String { return _url; }
		public function set url(value:String):void
		{
			_url = value;
		}
		
		public function get suppressError():Boolean { return _suppressError; }
		public function set suppressError(value:Boolean):void
		{
			_suppressError = value;
		}
	}
}