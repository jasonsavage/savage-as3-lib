package com.savage.views.preloaders
{
	
	//Script from http://www.stevensacks.net/2008/10/01/as3-apple-style-preloader/
	
	import com.savage.graphics.RectangleShape;
	import com.savage.views.View;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class CircleSlicePreloader extends View
	{
		public static var TIMER_DELAY:Number = 60;
		
		private var _timer:Timer;
		
		private var _slices:int = 12;
		private var _radius:int = 6;
		private var _color:uint = 0x666666;
		
		private var _updateChildren:Boolean;
		
		/**
		 * Constructor
		 */
		public function CircleSlicePreloader()
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_timer = new Timer(TIMER_DELAY);
			_timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			
			if (visible)
				_timer.start();
			
		}
		
		override public function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			removeAllChildren();
				
			var i:int = _slices;
			var degrees:int = 360 / _slices;
				
			while (i--)
			{
				var slice:RectangleShape = new RectangleShape(2, 6, color, 12);
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
					
				var radianAngle:Number = (degrees * i) * Math.PI / 180;
				slice.rotation = -degrees * i;
				slice.x = Math.sin(radianAngle) * radius;
				slice.y = Math.cos(radianAngle) * radius;
					
				addChild(slice);
			}
		}
		
		private function onTimerHandler(event:TimerEvent):void
		{
			rotation = (rotation + (360 / slices)) % 360;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		override public function get visible():Boolean { return super.visible; }
		override public function set visible(value:Boolean):void 
		{
			super.visible = value;
			
			if (_timer)
			{
				if (value)
					_timer.start();
				else
					_timer.reset();
			}
		}
		 
		public function get slices():int { return _slices; }
		public function set slices(value:int):void
		{
			_slices = value;
			invalidateDisplayList();
		}
		
		public function get radius():int { return _radius; }
		public function set radius(value:int):void
		{
			_radius = value;
			invalidateDisplayList();
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			_color = value;
			invalidateDisplayList();
		}
		
	}
}