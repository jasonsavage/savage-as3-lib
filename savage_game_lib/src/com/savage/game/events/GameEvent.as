package com.savage.game.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class GameEvent extends Event
	{
		public static const START_GAME:String = "startGame";
		public static const START_GAME_FROM_SAVED:String = "startGameFromSaved";
		
		public static const GAME_START:String = "gameStart";
		public static const GAME_END:String = "gameEnd";
		public static const GAME_STATE_CHANGE:String = "gameStateChange";
		public static const LEVEL_END:String = "levelEnd";
		
		/**
		 * Constructor
		 */
		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}