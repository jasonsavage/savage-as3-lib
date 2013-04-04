package com.savage.game.business 
{
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SavedGameManager
	{
		private static var _gameId:String;
		
		public static function setup(gameId:String):void
		{
			_gameId = gameId;
		}
		
		public static function save(data:String):void
		{
			if (!_gameId)
				throw new ArgumentError("Game id not set!");
			
			var so:SharedObject = SharedObject.getLocal(_gameId);
			so.clear(); //clear any old game data
			
			so.data.exists = true;
			so.data.createdate = new Date().getTime().toString();
			so.data.gamedata = data;
			so.flush();
		}
		
		public static function load():String
		{
			if (!_gameId)
				throw new ArgumentError("Game id not set!");
			
			var so:SharedObject = SharedObject.getLocal(_gameId);
			if (so.data && so.data.gamedata)
				return so.data.gamedata;
			
			return "";
		}
		
		public static function getCreateDate():int
		{
			var so:SharedObject = SharedObject.getLocal(_gameId);
			if (so.data && so.data.createdate)
				return parseInt(so.data.createdate);
			
			return -1;
		}
		
		public static function reset():void
		{
			var so:SharedObject = SharedObject.getLocal(_gameId);
			so.clear();
		}
		
	}

}