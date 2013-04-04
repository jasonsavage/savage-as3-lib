package com.savage.game 
{
	import com.savage.game.behaviors.Behavior;
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	
	/**
	 * ...
	 * @author 
	 */
	public class AgentBase extends Point 
	{
		private var _alpha:Number = 1;
		private var _size:Rectangle;
		
		private var _behaviors:Vector.<Behavior> = new Vector.<Behavior>();
		
		private var _transform:Transform;
		
		/**
		 * Constructor
		 */
		public function AgentBase(transform:Transform) 
		{
			super(0, 0);
			_transform = transform;
			
			_alpha = _transform.colorTransform.alphaMultiplier;
		}
		
		public function destroy():void
		{
			removeAllBehaviors();
			_transform = null;
		}
		
		public function getBehavior( className:Class ):Behavior 
		{
			for (var i:int = 0; i < _behaviors.length; i++) 
				if (_behaviors[i] is className)
					return _behaviors[i];
			
			return null;
		}
		
		public function addBehavior(b:Behavior):void
		{
			//set target
			b.agent = this;
			
			//add to collection
			_behaviors.push(b);
		}
		
		public function removeBehavior(b:Behavior, exit:Boolean=true):void
		{
			//set phase to end on next cycle
			if (exit)
				b.forceExit();
			else
				b.forceDestory();
		}
		
		public function removeAllBehaviors(exit:Boolean=true):void
		{
			//set phase to end on next cycle
			for (var i:int = 0; i < _behaviors.length; i++) 
				removeBehavior(_behaviors[i], exit);
		}
		
		/**
		 * Calling <code>render()</code> will set all postioning and sizing values on target to match it's Agent.
		 */
		public function render():void
		{
			var trans:ColorTransform = _transform.colorTransform;
			trans.alphaMultiplier = _alpha;
			
			if(_size)
			{
				_size.x = x;
				_size.y = y;
			}
		}
		
		/**
		 * Calling <code>update()</code> will update all behaviors on an Agent. 
		 * You will have to call <code>render()</code> to see the result of this update on the target.
		 */
		public function update():void
		{
			var dead:Vector.<int> = new Vector.<int>();
			
			for (var i:int = 0; i < _behaviors.length; i++) 
			{
				var b:Behavior = _behaviors[i];
				
				if ( b.step() )
				{
					//call destroy
					b.destroy();
						
					//remove reference from array
					dead.push(i);
				}
			}
			
			//clean up array
			while (dead.length)
				_behaviors.splice(dead.pop(), 1);
		}
		
		override public function toString():String 
		{
			return "[object AgentBase( behaviors: " + _behaviors.length + " )]";
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}

		public function get transform():Transform
		{
			return _transform;
		}
		
		public function get size():Rectangle { return _size; }
		public function set size(value:Rectangle):void
		{
			_size = value;
		}
		
	}

}