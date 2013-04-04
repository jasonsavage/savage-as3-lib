package com.savage.game.business
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class GameController extends EventDispatcher
	{
		
		//Up ( /\, 8, w)
		public var UP:Boolean;
		
		//Right ( >, 6, d)
		public var RIGHT:Boolean;
		
		//Down ( \/, 5, s)
		public var DOWN:Boolean;
		
		//Left ( <, 4, a)
		public var LEFT:Boolean;
		
		//true if down, false if up
		public var MOUSE:Boolean;
		
		private var game:DisplayObject;
		
		public function get mouseX():Number
		{
			if (game.stage)
				return game.stage.mouseX;
			return 0;
		}
		public function get mouseY():Number
		{
			if (game.stage)
				return game.stage.mouseY;
			return 0;
		}
		
		public function get stage():Stage
		{
			if (game.stage)
				return game.stage;
			return null;
		}
		
		/**
		 * Contructor
		 * */
		public function GameController( game:DisplayObject )
		{
			if(!allowCreation)
				throw new ArgumentError("GameController() is a singleton class and cannot be directly created. Use getInstance() instead.");
			
			allowCreation = false;
			
			//init settings
			UP = false;
			DOWN = false;
			LEFT = false;
			RIGHT = false;
			
			this.game = game;
			
			if (game.stage)
				addListeners();
			else
				game.addEventListener(Event.ADDED_TO_STAGE, onGame_AddedToStageHandler);
				
			game.addEventListener(Event.REMOVED_FROM_STAGE, onGame_RemovedfromStageHandler);
		}
		
		private function addListeners():void
		{
			var s:Stage = game.stage;
			s.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboard_KeyDownHandler);
			s.addEventListener(KeyboardEvent.KEY_UP, onKeyboard_KeyUpHandler);
			s.addEventListener(MouseEvent.MOUSE_DOWN, onMouse_ButtonDownHandler);
			s.addEventListener(MouseEvent.MOUSE_UP, onMouse_ButtonUpHandler);
		}
		
		private function removeListeners():void
		{
			var s:Stage = game.stage;
			s.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboard_KeyDownHandler);
			s.removeEventListener(KeyboardEvent.KEY_UP, onKeyboard_KeyUpHandler);
			s.removeEventListener(MouseEvent.MOUSE_DOWN, onMouse_ButtonDownHandler);
			s.removeEventListener(MouseEvent.MOUSE_UP, onMouse_ButtonUpHandler);
		}
		
		private function getDirection(keycode:uint):String
		{
			switch(keycode)
			{				
				case 87: //w
				case 38: //arrow-up
				case 56: //8
					return "UP";
				case 83: //s
				case 40: //arrow-down
				case 53: //5
					return "DOWN";
				case 65: //a
				case 37: //arrow-left
				case 52: //4
					return "LEFT";
				case 68: //d
				case 39: //arrow-right
				case 54: //6
					return "RIGHT";
			}
			return "";
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		/**
		 * Handles the KeyDown Event that is dispatched from Keyboard.
		 * @param event
		 */
		private function onKeyboard_KeyDownHandler(event:KeyboardEvent):void
		{
			var dir:String = this.getDirection(event.keyCode);
			if(dir != "")
				this[dir] = true;
		}
		
		/**
		 * Handles the KeyUp Event that is dispatched from Keyboard.
		 * @param event
		 */
		private function onKeyboard_KeyUpHandler(event:KeyboardEvent):void
		{
			var dir:String = this.getDirection(event.keyCode);
			if(dir != "")
				this[dir] = false;
		}
		
		/**
		 * Handles the ButtonDown Event that is dispatched from Mouse.
		 * @param event
		 */
		private function onMouse_ButtonDownHandler(event:MouseEvent):void
		{
			MOUSE = true;
		}
		
		/**
		 * Handles the ButtonUp Event that is dispatched from Mouse.
		 * @param event
		 */
		private function onMouse_ButtonUpHandler(event:MouseEvent):void
		{
			MOUSE = false;
			
			dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		/**
		 * Handles the AddedToStage Event that is dispatched from Game.
		 * @param event
		 */
		private function onGame_AddedToStageHandler(event:Event):void
		{
			game.removeEventListener(Event.ADDED_TO_STAGE, onGame_AddedToStageHandler);
			addListeners();
		}
		
		private function onGame_RemovedfromStageHandler(event:Event):void
		{
			removeListeners();
			game.removeEventListener(Event.REMOVED_FROM_STAGE, onGame_RemovedfromStageHandler);
		}
		
		/**************************************
		 * Static
		 **************************************/
		private static var instance:GameController;
		private static var allowCreation:Boolean = false;
		
		/**
		 * Sets up the GameController class on the target game.
		 * @param	site
		 */
		public static function initialize( game:DisplayObject ):void
		{
			allowCreation = true;
			instance = new GameController( game );
		}
		
		/**
		 * Returns an instance of the game controller.
		 * @return
		 */
		public static function getInstance():GameController
		{
			if(!instance)
				throw new Error("GameController has not be initialize on a specified game.");
				
			return instance;
		}
	}
}