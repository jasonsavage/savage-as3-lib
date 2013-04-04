package com.savage.ex.twitter
{
	import com.savage.utils.StringUtil;
	
	/**
	 * The TwitterUtil class ...
	 * @author jason.s
	 */
	public class TwitterUtil
	{
		public static function applyLinks(value:String, template:String="<a href='{0}'>{1}</a>"):String
		{
			var pattern:RegExp = /(^|\s)h(ttp(s*):\/\/[\w.\/]+)/g;
			return value.replace(pattern,  "$1" + StringUtil.format(template, "h$2", "h$2" )); 
		}
		
		public static function applyHashTagsLinks(value:String, template:String="<a href='{0}'>{1}</a>"):String
		{
			var pattern:RegExp = /(^|\s)#(\w+)/g;
			return value.replace(pattern, "$1" + StringUtil.format(template, "http://search.twitter.com/search?q=%23$2", "#$2" ) );
		}
		
		public static function applyUsernameLinks(value:String, template:String="<a href='{0}'>{1}</a>"):String
		{
			var pattern:RegExp = /(^|\s)@(\w+)/g;
			return value.replace(pattern, "$1" + StringUtil.format(template, "http://www.twitter.com/$2", "@$2" ) );
		}
		
		
		public static function formatLinks(value:String, template:String="{0}"):String
		{
			var pattern:RegExp = /(^|\s)(http(s*):\/\/[\w.\/]+)/g;
			return value.replace(pattern, "$1" + StringUtil.format(template, "$2" ) );
		}
		
		public static function formatUsernames(value:String, template:String="{0}"):String
		{
			var pattern:RegExp = /(^|\s)@(\w+)/g;
			return value.replace(pattern, "$1" + StringUtil.format(template, "@$2" ) );
		}
		
		public static function formatHashTags(value:String, template:String="{0}"):String
		{
			var pattern:RegExp = /(^|\s)#(#|\w+)/g;
			return value.replace(pattern, "$1" + StringUtil.format(template, " #$2" ) );
		}
		
	}
}