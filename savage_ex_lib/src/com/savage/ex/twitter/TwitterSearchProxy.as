package com.savage.ex.twitter
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.savage.model.URLLoaderProxy;
	
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	
	
	/**
	 * The TwitterSearchProxy class ...
	 * @author jason.s
	 */
	public class TwitterSearchProxy extends URLLoaderProxy
	{
		private var _jsonResult:Array;
		private var _timeoutId:uint;
		
		/**
		 * Constructor
		 */
		public function TwitterSearchProxy()
		{
			super();
			url = "http://search.twitter.com/search.json";
		}
		
		public function loadFeed(hashtag:String, p:int=1, rpp:int=20):void
		{
			if(hashtag.indexOf("#") != -1)
				hashtag = hashtag.replace(new RegExp("#","g"), "");
			
			load({
				q : "#" + hashtag,
				page : p,
				rpp : rpp,
				lang : "en"
			});
			
			_timeoutId = setTimeout(onTimeoutHandler, 8000);
			
		}
		
		private function onTimeoutHandler():void
		{
			unload();
			_success = false;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		override protected function proccessResult(content:String):void
		{
			clearTimeout(_timeoutId);
			
			var jsonData:JSONDecoder = new JSONDecoder(content, true);
			var results:Array = jsonData.getValue().results;
			for(var i:int = 0; i < results.length; i++)
			{
				results[i] = new TwitterSearchResultVO(results[i]);
			}
			
			_jsonResult = results;
			
		}
		
		public function get results():Array
		{
			return _jsonResult;
		}
		
		public function hasResults():Boolean
		{
			return (_jsonResult.length > 0);
		}
	}
}