package com.savage.views 
{
	import com.savage.layouts.FrameLayout;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoaderBase extends View 
	{
		private var _isLoaded:Boolean;
		private var _isLoading:Boolean;
		private var _loadOnCreate:Boolean;
		
		private var _loader:Loader;
		protected var _source:Object;
		
		private var _suppressInvalidateOnLoadComplete:Boolean;
		
		/**
		 * Constructor
		 */
		public function LoaderBase(self:LoaderBase) 
		{
			super();
			
			if (this != self)
				throw new ArgumentError("LoaderBase is an abstract base class; you cannot call LoaderBase directly, it must be subclassed.");
			
			layout = new FrameLayout();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			//create loader
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoader_InitHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoader_CompleteHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoader_ProgressHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoader_ErrorHandler);
			
			if (_loadOnCreate)
			{
				_loadOnCreate = false;
				loadSource();
			}
		}
		
		protected function resetLoader():void
		{
			try
			{
				if (_isLoading)
				{
					_isLoading = false;
					_loader.close();
				}
				
				if (_isLoaded)
				{
					_isLoaded = false;
					_loader.unload(); //clear out old data
				}
			}
			catch (e:Error)
			{
				//ignore any errors and reset flags
				_isLoading = false;
				_isLoaded = false;
			}
		}
		
		protected function loadSource():void
		{
			
		}
		
		public function unload():void
		{
			_isLoaded = false;
			_isLoading = false;
			
			resetLoader();
		}
		
		protected function getLoaderContext():LoaderContext
		{
			var context:LoaderContext = new LoaderContext(); 
            context.checkPolicyFile = true;
			return context;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		protected function onLoader_InitHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		} 
		
		/**
		 * Handles the Progress Event that is dispatched from loader.
		 * @param event
		 */
		protected function onLoader_ProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event.clone());
		} 
		
		/**
		 * Handles the Complete Event that is dispatched from loader.
		 * @param event
		 */
		protected function onLoader_CompleteHandler(event:Event):void
		{
			_isLoaded = true;
			_isLoading = false;
			
			//dispatch event
			dispatchEvent( new Event(Event.COMPLETE) );
			
			//invalidate
			if(!_suppressInvalidateOnLoadComplete)
				invalidateDisplayList();
		}
		
		/**
		 * Handles the Error Event that is dispatched from loader.
		 * @param event
		 */
		protected function onLoader_ErrorHandler(event:IOErrorEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get loaded():Boolean { return _isLoaded; }

		protected function get isLoaded():Boolean { return _isLoaded; }
		protected function set isLoaded(value:Boolean):void
		{
			_isLoaded = value;
		}
		
		protected function get isLoading():Boolean { return _isLoading; }
		protected function set isLoading(value:Boolean):void
		{
			_isLoading = value;
		}
		
		protected function get loader():Loader { return _loader; }

		public function get source():Object { return _source;}
		public function set source(value:Object):void
		{
			if (_source == value) return;
			
			_source = value;
			
			if (initialized)
				loadSource();
			else
				_loadOnCreate = true;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get suppressInvalidateOnLoadComplete():Boolean { return _suppressInvalidateOnLoadComplete; }
		public function set suppressInvalidateOnLoadComplete(value:Boolean):void
		{
			_suppressInvalidateOnLoadComplete = value;
		}
		
	}

}