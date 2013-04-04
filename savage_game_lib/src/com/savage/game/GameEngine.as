package com.savage.game 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author 
	 */
	public class GameEngine 
	{
		private var _agents:Vector.<AgentBase> = new Vector.<AgentBase>();
		private var _deadAgents:Vector.<AgentBase> = new Vector.<AgentBase>();
		
		private var _timer:Timer;
		
		private var _lastTime:int;
		private var _onLoop:Function;
		
		//amount of time to sleep for (in milliseconds)
		private var _delay:int = 20;
		
		/**
		 * Constructor
		 * @param	engine
		 */
		public function GameEngine() 
		{
			_timer = new Timer(_delay);
			_timer.addEventListener(TimerEvent.TIMER, run);
		}
		
		public function start():void
		{
			Time.startTime = getTimer();
			_lastTime = Time.startTime -_delay;
			_timer.start();
		}
		
		public function stop():void
		{
			_timer.stop();
			_timer.reset();
			Time.startTime = 0;
		}
		
		public function addAgent(agent:AgentBase):void
		{
			//add agent to Stack
			_agents.push(agent);
		}
		
		public function removeAgent(agent:AgentBase):void
		{
			_deadAgents.push(agent);
		}
		
		public function removeAllAgents():void
		{
			_deadAgents = _deadAgents.concat(_agents);
		}

		private function updateAgents():void
		{
			for (var i:int = 0; i < _agents.length; i++) 
				_agents[i].update();
				
			//clean up dead agents
			while (_deadAgents.length)
			{
				var a:AgentBase = _deadAgents.pop();
				var index:int = _agents.indexOf(a);
				if (index != -1)
				{
					a.destroy();
					_agents.splice(index, 1);
				}
			}
		}

		private function renderAgents():void
		{
			//loop through array and render each element
			for (var i:int = 0; i < _agents.length; i++) 
				_agents[i].render();
		}
		
		protected function run(event:Event=null):void
		{
			//update time
			Time.time = getTimer() - Time.startTime;
			Time.deltaTime = (Time.time - _lastTime)/1000;
			
			if(_onLoop != null)
				_onLoop();
			
			//update all the agents in the gameEngine
			updateAgents();
				 
			//show the result of the updated agents
			renderAgents();
			
			_lastTime = Time.time;
		}
		
		
		public function get onLoop():Function { return _onLoop; }
		public function set onLoop(value:Function):void
		{
			if (_onLoop == value)
				return;
			_onLoop = value;
		}
		
	}

}