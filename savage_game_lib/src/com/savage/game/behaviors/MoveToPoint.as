package com.savage.game.behaviors 
{
	import com.savage.game.Time;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class MoveToPoint extends Behavior 
	{
		private var _point:Point;
		private var _duration:Number;
		private var _change:Point;
		private var _start:Point;
		private var _startTime:int;
		
		public function MoveToPoint(pt:Point, duration:Number) 
		{
			super();
			_point = pt;
			_duration = duration;
		}
		
		override public function enter():void 
		{
			super.enter();
			
			_change = new Point(_point.x - agent.x, _point.y - agent.y);
			_start = new Point(agent.x, agent.y);
			_startTime = Time.time;
		}
		
		override public function update():void 
		{
			super.update();
			
			var curTime:Number = (Time.time - _startTime);
			
			if (curTime < _duration)
			{
				agent.x = easeOut(curTime, _start.x, _change.x, _duration);
				agent.y = easeOut(curTime, _start.y, _change.y, _duration);
			}
			else
			{
				agent.x = _point.x;
				agent.y = _point.y;
				valid = false;
			}
		}
		
		private function easeOut(t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * (t /= d) * (t - 2) + b;
		}
	}

}