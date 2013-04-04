package com.savage.game.business
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	
	/**
	 * the SoundManager class provides an interface to play sounds during gameplay and
	 * helps to limit the amount of sounds that can play at a time.
	 * 
	 * @author Jason Savage
	 */
	public class SoundManager 
	{
		public static var SOUND_LIMIT:int = 3;
		
		private static var _soundLib:Dictionary = new Dictionary();
		private static var _channels:Vector.<SoundChannel> = new Vector.<SoundChannel>();

		
		/**
		 * Register a sound with the SoundManager for use with the play method.
		 * @param	name
		 * @param	sound
		 */
		public static function registerSound(name:String, sound:Sound):void
		{
			_soundLib[name] = sound;
		}
		
		/**
		 * Unregister a sound with the sound manager.
		 * @param	name
		 */
		public static function unregisterSound(name:String):void
		{
			_soundLib[name] = null;
		}
		
		/**
		 * Retuns true or false if a sound was prevously register by the name specified.
		 * @param	name
		 * @return
		 */
		public static function hasSound( name:String ) : Boolean
		{
			return (_soundLib[name] != null);	
		}
		
		/**
		 * Returns the a sound was prevously register by the name specified.
		 * @param	name
		 * @return
		 */
		private static function getSound( name:String ):Sound
		{
			return _soundLib[name];
		}
		
		/**
		 * Plays a sound prevously register by the name specified. 
		 * This method prevents flash from playing too many sounds at once.
		 * @param	sound
		 * @return
		 */
		public static function playSound(name:String):SoundChannel
		{
			if (_channels.length > SOUND_LIMIT)
				return null; //block
			
			var sound:Sound = getSound(name);
			if (!sound)
				throw new Error("Attempted to play a sound, ("+ name +"), that is not registered with the SoundManager. ");
				
			var ch:SoundChannel = sound.play();
			ch.addEventListener(Event.SOUND_COMPLETE, onSound_CompleteHandler);
			_channels.push(ch);
			
			return ch;
		}
		
		private static function onSound_CompleteHandler(event:Event):void
		{
			var ch:SoundChannel = event.target as SoundChannel;
			var i:int = _channels.indexOf(ch);
			if (i != -1)
				_channels.splice(i, 1);
		}
	}
	
}