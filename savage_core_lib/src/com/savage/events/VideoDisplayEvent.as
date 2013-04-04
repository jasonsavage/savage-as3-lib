package com.savage.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class VideoDisplayEvent extends Event 
	{
		public static const STATE_CHANGE:String = "stateChange";
		public static const SOURCE_CHANGE:String = "sourceChange";
		public static const COMPLETE:String = "complete";
		public static const START:String = "start";
		public static const ERROR:String = "error";
		
		public static const CUE_POINT:String = "cuePoint";
		public static const META_DATA:String = "metaData";
		public static const XMP_DATA:String = "xmpData";
		
		private var _data:Object;
		
		/**
		 * Constructor
		 */
		public function VideoDisplayEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:Object=null) 
		{ 
			super(type, bubbles, cancelable);
			_data = data;
		} 
		
		public override function clone():Event 
		{ 
			return new VideoDisplayEvent(type, bubbles, cancelable, data);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("VideoDisplayEvent", "type", "bubbles", "cancelable", "data", "eventPhase"); 
		}
		
		public function get data():Object { return _data; }
		public function set data(value:Object):void
		{
			_data = value;
		}
		
	}
	
}