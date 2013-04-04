package com.savage.ex.twitter
{
	
	/**
	 * The TwitterSearchResultVO class ...
	 * @author jason.s
	 */
	public class TwitterSearchResultVO
	{
		public var from_user_id_str:String;
		public var profile_image_url:String;
		public var created_at:String;
		public var from_user:String;
		public var id_str:String;
		public var metadata:Object;
		public var to_user_id:Object;
		public var text:String;
		public var id:String;
		public var from_user_id:String;
		public var geo:String;
		public var iso_language_code:String;
		public var to_user_id_str:String;
		public var source:String;
		public var to_user:String;
		
		/**
		 * Constructor
		 */
		public function TwitterSearchResultVO(data:Object=null)
		{
			if(data)
			{
				for(var key:String in data)
				{
					if(hasOwnProperty(key))
						this[key] = data[key];
				}
			}
		}
		
		public function isEmpty():Boolean
		{
			return (id_str == null);
		}
	}
}