package com.savage.ex.twitter
{
	
	/**
	 * The TweetBlockList class ...
	 * @author jason.s
	 */
	public class TweetBlockList
	{
		private static var _blockList:Array = new Array();
		
		/**
		 * Add tweet to the blocked list.
		 */
		public static function block( tweetId:String ):void
		{
			if(!isBlocked(tweetId))
				_blockList.push( tweetId );
		}
		
		public static function unblock( tweetId:String ):void
		{
			if(isBlocked(tweetId))
				_blockList.splice(_blockList.indexOf(tweetId), 1);
		}
		
		/**
		 * Checks if the current tweet is blocked
		 */
		public static function isBlocked(tweetId:String):Boolean
		{
			return (_blockList.indexOf(tweetId) != -1);
		}
		
		/**
		 * Removes all blocked tweets from the blocked list.
		 */
		public static function clear():void
		{
			_blockList.length = 0;
		}
	}
}