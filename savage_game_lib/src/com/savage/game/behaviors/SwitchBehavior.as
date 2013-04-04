package com.savage.game.behaviors 
{
	/**
	 * ...
	 * @author 
	 */
	public class SwitchBehavior extends Behavior 
	{
		private var _to:Behavior;
		private var _from:Behavior;
		
		/**
		 * Constructor
		 */
		public function SwitchBehavior(from:Behavior, to:Behavior) 
		{
			super();
			
			_from = from;
			_to = to;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!_from.valid)
			{
				agent.addBehavior(_to);
				valid = false;
			}
		}
		
	}

}