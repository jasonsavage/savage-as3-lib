package com.savage.game.behaviors
{
	import com.savage.game.GameEngine;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	/**
	 * The DrawAgentsSizeBehavior class ...
	 * @author jason.s
	 */
	public class DrawAgentsSizeBehavior extends Behavior
	{
		private var _graphics:Graphics;
		private var _engine:GameEngine;
		
		/**
		 * Constructor
		 */
		public function DrawAgentsSizeBehavior(engine:GameEngine, graphics:Graphics)
		{
			super();
			_graphics = graphics;
			_engine = engine;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_graphics = null;
			
			_engine.onLoop = null;
			_engine = null;
		}
		
		override public function enter():void
		{
			// TODO Auto Generated method stub
			super.enter();
			
			if(_engine.onLoop == null)
				_engine.onLoop = onGameEngineLoop;
		}
		
		override public function update():void
		{
			super.update();
			
			_graphics.lineStyle(1,0x80FFFF);
			_graphics.drawRect(agent.size.x, agent.size.y, agent.size.width, agent.size.height);
			_graphics.lineStyle(0);
			
		}
		
		private function onGameEngineLoop():void
		{
			_graphics.clear();
		}
		
	}
}