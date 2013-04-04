package com.savage.core
{
	
	import com.savage.model.ConfigProxy;
	import com.savage.model.FlashVarsProxy;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	
	
	/**
	 * The ApplicationBase class should be used as the document class for you flash application.
	 * ApplicationBase loads in a content swf at the beginning and displays it on startup app.
	 * 
	 * @author Jason Savage
	 * @see com.savage.core.ApplicationFacade
	 * @see com.savage.core.AppComponent
	 */
	public class ApplicationBase extends Sprite
	{
		private static const ERROR_ABSTRACT_CLASS:String = "The ApplicationBase class cannot be instantiated directly it must be extended and used as the document class of a project.";
		private static const ERROR_TOP_LEVEL:String = "ApplicationBase cannot be a child of another DisplayObject, your document class must extend ApplicationBase";
		
		public static var application:ApplicationBase;
		
		/**************************************
		 * Properties
		 **************************************/
		private var _contentLoader:Loader;
		private var _uiBlocker:Sprite;
		private var _initialized:Boolean;
		private var _facade:ApplicationFacade;
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get disableUI():Boolean { return _uiBlocker.visible; }
		public function set disableUI(value:Boolean):void
		{
			_uiBlocker.visible 	= value;
			_uiBlocker.width 	= width;
			_uiBlocker.height 	= height;
		}
		
		protected function get contentLoader():Loader
		{
			return _contentLoader;
		}
		
		protected function get content():AppComponent
		{
			return _contentLoader.content as AppComponent;
		}
		
		protected function get facade():ApplicationFacade
		{
			return _facade;
		}
		
		/**************************************
		 * Constructor / Initalizers
		 **************************************/
		/**
		 * Constructor
		 */
		public function ApplicationBase( self:ApplicationBase )
		{
			super();
			application = this;
			
			//validate
			if (self != this)
            	throw new Error(ERROR_ABSTRACT_CLASS);
			
			if (root != this)
				throw new Error(ERROR_TOP_LEVEL);
			
			if (!stage)
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			else
				onAddedToStage(null);
		}
		
		/**
		 * Called after the swf and config file have been loaded and the application is ready to start.
		 */
		protected function startupApp():void 
		{
			//override to start app
		}
		
		/**************************************
		 * Private / Protected
		 **************************************/
		
		/**
		 * This method is called after the ApplicationBase has been added to stage. At this point in the loading process you will
		 * not have access to any application settings in the swfconfig.xml through the facade. 
		 * You can override <code>processAppConfig()</code> if you need any application settings before your content swf loads.
		 */
		protected function initialize():void
		{
			if (_initialized)
				return;
			
			//Initalize facade
			_facade = ApplicationFacade.getInstance();
			
			//add child objects
			createChildren();
			
			//register proxies & load application config
			_facade.registerProxy(FlashVarsProxy.NAME, new FlashVarsProxy(this.loaderInfo.parameters));
			_facade.registerProxy(ConfigProxy.NAME, ConfigProxy.load( facade.resolveAssetsPath(""), processAppConfig, true) );
			
			_initialized = true;
		}
		
		/**
		 * Called by <code>initialize()</code> to add the _contentLoader and _uiBlocker to the display list.
		 */
		protected function createChildren():void
		{
			//add main content swf
			_contentLoader = new Loader();
			_contentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAppLoadComplete);
			_contentLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onAppLoadProgress);
			_contentLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onAppLoadError);
			addChild(_contentLoader);
			
			//add UI blocker
			_uiBlocker = new Sprite();
			_uiBlocker.graphics.beginFill(0, 1);
			_uiBlocker.graphics.drawRect(0, 0, 100, 100);
			_uiBlocker.graphics.endFill();
			_uiBlocker.alpha = 0;
			_uiBlocker.visible = false;
			addChild(_uiBlocker);
		}
		 
		/**
		 * Convenence method to send a notification to the Notification service in the facade.
		 * @param	notificationName
		 * @param	body
		 */
		protected function sendNotification( name:String, body:Object=null):void 
		{
			_facade.sendNotification(name, body);
		}
		
		/**
		 * This method is called after the config file is loaded and before <code>startupApp</code>.
		 */
		protected function processAppConfig(event:Event=null):void 
		{
			var request:URLRequest = new URLRequest( _facade.getContentSwfURL() );
			_contentLoader.load( request );
		}
		
		/**************************************
		 * Handler
		 **************************************/
		
		/**
		 * Handles the Progress Event that is dispatched from _contentLoader.
		 * @param event
		 */
		protected function onAppLoadProgress(event:ProgressEvent):void { } 
		
		/**
		 * Handles the Complete Event that is dispatched from _contentLoader.
		 * @param event
		 */
		protected function onAppLoadComplete(event:Event):void
		{
			if (contentLoader.content is MovieClip)
			{
				var mc:MovieClip = contentLoader.content as MovieClip;
				if (mc.framesLoaded < mc.totalFrames)
				{
					setTimeout(onAppLoadComplete, 200, event);
					return;
				}
			}
			
			//start app
			setTimeout(startupApp, 200);
		}
		
		/**
		 * Handles the Error Event that is dispatched from _contentLoader.
		 * @param event
		 */
		protected function onAppLoadError(event:IOErrorEvent):void { }
		
		
		protected function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//initialize app
			initialize();
		}
	}
}