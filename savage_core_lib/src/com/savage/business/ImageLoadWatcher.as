package com.savage.business 
{
	import com.savage.views.ImageView;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ImageLoadWatcher extends EventDispatcher
	{
		private var _loadIndex:int;
		private var _images:Vector.<ImageView>;
		
		public function get length():int
		{
			return _images.length;
		}
		
		/**
		 * Constructor
		 */
		public function ImageLoadWatcher() 
		{
			super();
			
			_loadIndex = 0;
			_images = new Vector.<ImageView>();
		}
		
		public function registerView(view:ImageView):void
		{
			view.addEventListener(Event.COMPLETE, onImage_CompleteHandler, false, 0, true);
			view.suppressInvalidateOnLoadComplete = true;
			_images.push(view);
		}
		
		public function unregisterView(view:ImageView):void
		{
			var i:int = _images.indexOf(view);
			if (i != -1)
			{
				view.removeEventListener(Event.COMPLETE, onImage_CompleteHandler);
				view.suppressInvalidateOnLoadComplete = false;
				_images.splice(i, 1);
			}
		}
		
		private function onImage_CompleteHandler(event:Event):void
		{
			var view:ImageView = event.target as ImageView;
			view.removeEventListener(Event.COMPLETE, onImage_CompleteHandler);
			view.suppressInvalidateOnLoadComplete = false;
			
			_loadIndex++;
			
			if (_loadIndex >= _images.length)
			{
				//clear out array
				_images.length = 0;
				
				//reset index
				_loadIndex = 0;
				
				//dispatchEvent
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}

}