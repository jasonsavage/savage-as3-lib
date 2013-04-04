package com.savage.views 
{
	import com.savage.layouts.AbsoluteLayout;
	import com.savage.layouts.FrameLayout;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author 
	 */
	public class MovieClipView extends LoaderBase 
	{
		private var _centerContent:Boolean;
		private var _isMovieClip:Boolean;
		
		//children
		private var _content:DisplayObject;
		
		/**
		 * Constructor
		 */
		public function MovieClipView() 
		{
			super(this);
		}
		
		public function play():void
		{
			if (_content && _isMovieClip)
				MovieClip(_content).play();
		}
		
		public function stop():void
		{
			if (_content && _isMovieClip)
				MovieClip(_content).stop();
		}
		
		public function gotoAndPlay(frame:Object, scene:String=null):void
		{
			if (_content && _isMovieClip)
				MovieClip(_content).gotoAndPlay(frame, scene);
		}
		
		public function gotoAndStop(frame:Object, scene:String=null):void
		{
			if (_content && _isMovieClip)
				MovieClip(_content).gotoAndStop(frame, scene);
		}
		
		override protected function loadSource():void
		{
			super.loadSource();
			
			//load source based on type
			if (source is String && String(source) != "")
			{
				resetLoader();
				clearContent();
				
				//load new source
				isLoading = true;
				loader.load(new URLRequest(source as String), getLoaderContext());
			}
			else if (source as DisplayObject)
			{
				//update flags
				isLoaded = true;
				isLoading = false;
				
				//set new bitmapData
				updateContent( source as DisplayObject );
				
				//dispatch event
				dispatchEvent( new Event(Event.COMPLETE) );

				//invalidate
				if (!suppressInvalidateOnLoadComplete)
					invalidateDisplayList();
			}
			else
			{
				throw new ArgumentError("source is not a recognized object");
			}
		}
		
		override public function unload():void 
		{
			super.unload();
			clearContent();
		}
		
		private function clearContent():void 
		{
			if (_content)
			{
				if (contains(_content))
				{
					suppressInvalidateOnAddRemoveChild = true;
					removeChild(_content);
					suppressInvalidateOnAddRemoveChild = false;
				}
					
				_content = null;
			}
		}
		
		private function updateContent(newContent:DisplayObject):void 
		{
			clearContent();
			
			suppressInvalidateOnAddRemoveChild = true;
			
			_content = newContent;
			addChildAt(_content, 0);
			
			suppressInvalidateOnAddRemoveChild = false;
			
			_isMovieClip = (_content is MovieClip);
		}
		
		override public function updateDisplayList():void 
		{
			if (_centerContent)
			{
				if (layout is FrameLayout)
					layout = new AbsoluteLayout();
					
				if (_content)
				{
					_content.x = _content.width * -0.5;
					_content.y = _content.height * -0.5;
				}
			}
			else
			{
				if (layout is AbsoluteLayout)
					layout = new FrameLayout();
			}
			
			super.updateDisplayList();
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		override protected function onLoader_CompleteHandler(event:Event):void 
		{
			if ( loader.content is MovieClip || loader.content is Sprite)
				updateContent(loader.content as DisplayObject);
			
			super.onLoader_CompleteHandler(event);
		}
		
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get currentFrame():int 
		{ 
			return (_content && _isMovieClip) ? MovieClip(_content).currentFrame : -1; 
		}
		
		public function get totalFrames():int 
		{ 
			return (_content && _isMovieClip) ? MovieClip(_content).totalFrames : -1; 
		}
	}

}