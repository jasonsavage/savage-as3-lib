package com.savage.views
{
	import com.savage.layouts.AbsoluteLayout;
	import com.savage.layouts.FrameLayout;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * The ImageView class wraps a Bitmap and can be used to display an image. 
	 * Values for the source property can be a Bitmap, BitmapData, or a url to an image that needs to be loaded.
	 * If a String is used the image will auto load at runtime.
	 * @author Jason Savage
	 */
	public class ImageView extends LoaderBase
	{
		private var _centerContent:Boolean;
		
		//children
		private var _bitmap:Bitmap;
		
		/**
		 * Constructor
		 */
		public function ImageView() 
		{
			super(this);
			mouseChildren = false;
		}
		
		override public function removeChildAt(index:int):DisplayObject 
		{
			if(getChildAt(index) != _bitmap)
				return super.removeChildAt(index);
			return null;
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add bitmap
			_bitmap = new Bitmap(null, "auto", true);
			addChild(_bitmap);
		}
		
		override protected function loadSource():void
		{
			super.loadSource();
			
			//set source ref to the bitmapData instead of the bitmap
			if (_source is Bitmap)
				_source = Bitmap(source).bitmapData;
			
			//load source based on type
			if (_source is String && String(_source) != "")
			{
				resetLoader();
				clearBitmap();
				
				//load new source
				isLoading = true;
				loader.load(new URLRequest(_source as String), getLoaderContext());
			}
			else if (_source is BitmapData)
			{
				//update flags
				isLoaded = true;
				isLoading = false;
				
				//set new bitmapData
				updateBitmap( _source as BitmapData );
				
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
			clearBitmap();
		}
		
		override public function updateDisplayList():void 
		{
			if (_centerContent)
			{
				if (layout is FrameLayout)
					layout = new AbsoluteLayout();
					
				_bitmap.x = _bitmap.width * -0.5;
				_bitmap.y = _bitmap.height * -0.5;
			}
			else
			{
				if (layout is AbsoluteLayout)
					layout = new FrameLayout();
			}
			
			super.updateDisplayList();
		}
		
		private function clearBitmap():void
		{
			if (_bitmap && _bitmap.bitmapData)
			{
				_bitmap.bitmapData.dispose();
				_bitmap.bitmapData = null;
			}
		}
		
		private function updateBitmap(bm:BitmapData):void
		{
			clearBitmap();
				
			_bitmap.bitmapData = bm;
			_bitmap.smoothing = true;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		/**
		 * Handles the Complete Event that is dispatched from loader.
		 * @param event
		 */
		override protected function onLoader_CompleteHandler(event:Event):void
		{
			//update internal bitmap
			if (loader.content is Bitmap)
				updateBitmap( Bitmap(loader.content).bitmapData );
			
			super.onLoader_CompleteHandler(event);
		}
		
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
		public function get bitmapData():BitmapData 
		{
			return _bitmap.bitmapData;
		}
		
		public function get centerContent():Boolean { return _centerContent; }
		public function set centerContent(value:Boolean):void
		{
			_centerContent = value;
			
			if(isLoaded)
				invalidateDisplayList();
		}
	}

}