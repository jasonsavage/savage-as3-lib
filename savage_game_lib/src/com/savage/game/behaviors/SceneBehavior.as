package com.savage.game.behaviors
{
	import flash.display.Sprite;
	
	import mx.states.OverrideBase;
	
	/**
	 * The SceneBehavior class ...
	 * @author jason.s
	 */
	public class SceneBehavior extends Behavior
	{
		private var _scene:Sprite;
		
		/**
		 * Constructor
		 */
		public function SceneBehavior(scene:Sprite)
		{
			super();
			_scene = scene;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_scene = null;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get scene():Sprite { return _scene; }
		public function set scene(value:Sprite):void
		{
			_scene = value;
		}
		
	}
}