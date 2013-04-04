package com.savage.game.business 
{
	import com.savage.game.interfaces.ILevelData;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class LevelManager
	{
		private static var _levels:Array;
		private static var _index:int;
		
		/**
		 * Sets up the LevelManager.
		 * @param	levelData
		 */
		public static function setup(levelData:ILevelData):void 
		{ 
			_index = 0;
			_levels = levelData.getLevelData();
		}
		
		public static function reset():void 
		{ 
			_index = 0;
		}
		
		/**
		 * Moves the LevelManager to the next level.
		 */
		public static function gotoNextLevel():Boolean
		{
			_index++;
			
			return (_index < _levels.length);
		}
		
		/**
		 * Moves the LevelManager to the previous level.
		 */
		public static function gotoPrevLevel():Boolean 
		{
			_index--;
			return (_index > 0);
		}
		
		/**
		 * Gets the current level.
		 * @return
		 */
		public static function getCurrentLevel():Object 
		{
			if (_index > _levels.length - 1)
				return null;
			
			return _levels[_index];
		}
		
		public static function getCurrentLevelIndex():int
		{
			return _index;
		}
		
		public static function setCurrentLevelIndex(value:int):void
		{
			_index = value;
		}
		
	}

}