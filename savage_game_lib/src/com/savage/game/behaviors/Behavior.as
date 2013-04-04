package com.savage.game.behaviors 
{
	import com.savage.game.Agent3D;
	import com.savage.game.AgentBase;
	
	/**
	 * ...
	 * @author 
	 */
	public class Behavior 
	{
		public static const PHASE_ENTER:int 	= 1;
		public static const PHASE_UPDATE:int 	= 2;
		public static const PHASE_EXIT:int 		= 3;
		public static const PHASE_DESTROY:int 	= 4;
		
		private var _agent:AgentBase;
		private var _phase:int = PHASE_ENTER;
		private var _valid:Boolean = true;
		
		/**
		 * Constructor
		 */
		public function Behavior() { }
		
		public function enter():void {}
		public function update():void {}
		public function exit():void { }
		
		public function destroy():void 
		{ 
			_agent = null;
			_phase = PHASE_ENTER;
			_valid = true;
		}
		
		public final function step():Boolean 
		{ 
			switch(_phase)
			{
				case Behavior.PHASE_ENTER :
					
					//call enter 
					enter();
					
					//update behavior phase
					_phase = Behavior.PHASE_UPDATE;
					
				break;
				
				case Behavior.PHASE_UPDATE :
					
					//update behavior 
					update();
					
					//update behavior phase if behavior is no longer valid
					if (!_valid)
						_phase = Behavior.PHASE_EXIT;
						
				break;
				
				case Behavior.PHASE_EXIT :
					
					//call exit
					exit();
					
					//set behavior to destroy
					_phase = Behavior.PHASE_DESTROY;
					
				break;
			}
			
			return (_phase == Behavior.PHASE_DESTROY);
		}
		
		public function forceExit():void
		{
			_phase = Behavior.PHASE_EXIT;
		}
		
		public function forceDestory():void
		{
			_phase = Behavior.PHASE_DESTROY;
		}

		/**************************************
		 * Accessors
		 **************************************/
		
		public function get agent():AgentBase { return _agent; }
		public function set agent(value:AgentBase):void
		{
			_agent = value;
		}
		
		public function get agent3D():Agent3D
		{
			return _agent as Agent3D;
		}
		
		public function get valid():Boolean { return _valid; }
		public function set valid(value:Boolean):void
		{
			_valid = value;
		}
	}

}