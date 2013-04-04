package com.savage.game.business 
{
	import com.savage.game.interfaces.IScreenMenu;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	
	/**
	 * The ScreenManager class provides an interface to add and remove screens from the display.
	 * @author ...
	 */
	public class ScreenManager 
	{
		private static var _display:DisplayObjectContainer;
		
		private static var _currentScreen:IScreenMenu;
		private static var _nextScreen:IScreenMenu;
		
		/**
		 * Constructor
		 * @param	container
		 */
		public static function setup(display:DisplayObjectContainer):void
		{
			_display = display;
			_currentScreen = null;
			_nextScreen = null;
		}
			
		/**
		 * Adds a screen to the display list and calls <code>IScreenMenu.show()</code>.
		 * @param	screen - menu to display
		 */
		public static function load( screen:IScreenMenu ):void
		{
			//if screen is null then cancel
			if ( !screen ) return;
			
			_currentScreen = screen;
			
			//add screen to display
			if ( !_display.contains( _currentScreen as DisplayObject ) )
				_display.addChild( _currentScreen as DisplayObject );
			
			//show screen
			_currentScreen.show();
		}
			
		/**
		 * Removes a screen from the display list and calls <code>IScreenMenu.hide()</code>.
		 * @param	screen - next menu to display
		 */
		public static function unload( screen:IScreenMenu=null, wait:Boolean=true ):void
		{
			_nextScreen = screen;
			
			if ( _currentScreen)
			{
				if ( wait )
				{
					_currentScreen.addEventListener(Event.COMPLETE, onScreenHide_CompleteHandler);
					_currentScreen.hide();
				}
				else
				{
					_currentScreen.hide();
					load( _nextScreen );
				}
			}
			else
			{
				load( _nextScreen );
			}
		}
		
		/**
		 * When a screen is done hiding, this loads the next menu.
		 * You must dispatch Event.COMPLETE from the screen that is hiding.
		 * @param	event
		 */
		private static function onScreenHide_CompleteHandler(event:Event):void
		{
			_currentScreen.removeEventListener(Event.COMPLETE, onScreenHide_CompleteHandler);
			
			if ( _display.contains( _currentScreen as DisplayObject ) )
				_display.removeChild( _currentScreen as DisplayObject );
			
			//load next screen
			load( _nextScreen );
		}
		
		public static function get currentScreen():IScreenMenu { return _currentScreen; }
		public static function get nextScreen():IScreenMenu { return _nextScreen; }
	}

}