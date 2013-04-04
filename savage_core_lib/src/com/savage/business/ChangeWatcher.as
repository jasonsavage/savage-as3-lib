package com.savage.business
{
	import com.savage.utils.StringUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * The ChangeWatcher class ...
	 * @author jason.s
	 */
	public class ChangeWatcher
	{
		private var _src:EventDispatcher;
		private var _srcProp:String;
		
		private var _dest:EventDispatcher;
		private var _destProp:String;
		
		private var _suppressNextUpdate:Boolean;
		
		/**
		 * Constructor
		 */
		public function ChangeWatcher(src:EventDispatcher, srcProp:String, dest:EventDispatcher, destProp:String, toWay:Boolean) 
		{
			_src = src;
			_srcProp = srcProp;
			_dest = dest;
			_destProp = destProp;
			
			_src.addEventListener(Event.CHANGE, updateDestination);
			
			if(toWay)
				_dest.addEventListener(Event.CHANGE, updateSource);
		}
		
		public function destroy():void
		{
			_src.removeEventListener(Event.CHANGE, updateDestination);
			_dest.removeEventListener(Event.CHANGE, updateSource);
			
			_src = null;
			_dest = null;
		}
		
		private function updateSource(event:Event):void
		{
			if(_suppressNextUpdate)
			{
				_suppressNextUpdate = false;
				return;
			}
			else
			{
				//check if source property != destination property
				if( _src[_srcProp] != _dest[_destProp] )
				{
					//suppress and update property
					_suppressNextUpdate = true;
					_src[_srcProp] = _dest[_destProp];
				}
			}
		}
		
		private function updateDestination(event:Event):void
		{
			if(_suppressNextUpdate)
			{
				_suppressNextUpdate = false;
				return;
			}
			else
			{
				//check if destination property != source property
				if(_dest[_destProp] != _src[_srcProp] )
				{
					//suppress and update property
					_suppressNextUpdate = true;
					_dest[_destProp] = _src[_srcProp];
				}
			}
		}
		
		/**************************************
		 * Static
		 **************************************/
		
		public static var _dictonary:Dictionary = new Dictionary(true);
		
		public static function watch(src:EventDispatcher, srcProp:String, dest:EventDispatcher, destProp:String, toWay:Boolean):String
		{
			//generate key
			var key:String = StringUtil.generateCode(10);
			
			//create change watcher
			_dictonary[key] = new ChangeWatcher(src, srcProp, dest, destProp, toWay);
			
			return key;
		}
		
		public static function unwatch(key:String):void
		{
			if( _dictonary[key] )
			{
				ChangeWatcher( _dictonary[key] ).destroy();
				_dictonary[key] = null;
			}
		}
		
		public static function unwatchAll():void
		{
			for(var key:String in _dictonary)
				unwatch(key);
			
			_dictonary = new Dictionary(true);
		}
	}
}