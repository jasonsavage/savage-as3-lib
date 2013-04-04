package com.savage.business 
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class TextLoader extends URLLoader 
	{
		private var _field:TextField;
		
		/**
		 * Constructor
		 * @param	field
		 * @param	request
		 */
		public function TextLoader(field:TextField, request:URLRequest = null) 
		{
			super(request);
			
			_field = field;
			
			addEventListener(Event.COMPLETE, onLoader_CompleteHandler);
			addEventListener(ProgressEvent.PROGRESS, onLoader_ProgressHandler);
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		private function onLoader_ProgressHandler(event:ProgressEvent):void 
		{
			var perc:Number = event.bytesLoaded / event.bytesTotal;
			_field.text = "Loading: " + int(perc * 100) + "%";
		}
		
		private function onLoader_CompleteHandler(event:Event):void 
		{
			_field.text = data as String;
			_field = null;
		} 
	}

}