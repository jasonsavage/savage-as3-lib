package com.savage.business
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * The AutoRotator class is used to setup a timer that will run only while the users mouse is not over the swf file on a page. 
	 * This is mostly used for slideshows and banners.
	 * @author Jason Savage
	 */
	public class AutoRotator extends EventDispatcher
	{
		/**
		 * This class will dispatch <code>new Event(AutoRotator.ROTATE)</code> on each tick of the internal timer.
		 */
		public static const ROTATE:String = "rotate";
		
		private var _stage:Stage;
		private var _timer:Timer;
		private var _hasListeners:Boolean;
		
		/**
		 * Constructor
		 */
		public function AutoRotator(stage:Stage, delay:int=2000) 
		{
			super();
			
			if (!stage)
				throw new ArgumentError("stage cannot be null");
			
			_stage = stage;

			_timer = new Timer(delay);
			_timer.addEventListener(TimerEvent.TIMER, onTimer_TickHandler);
		}
		
		/**
		 * Starts the internal timer and listens for <code>Event.MOUSE_LEAVE</code> from the stage object.
		 */
		public function start():void
		{
			if (!_hasListeners)
			{
				_hasListeners = true;
				_stage.addEventListener(Event.MOUSE_LEAVE, onStage_MouseLeaveHandler);
			}
			
			_timer.start();
		}
		
		/**
		 * Stops the internal timer and removes all listeners from the stage object.
		 */
		public function stop():void
		{
			if (_hasListeners)
			{
				_hasListeners = false;
				_stage.removeEventListener(MouseEvent.MOUSE_OVER, onStage_MouseOverHandler);
				_stage.removeEventListener(Event.MOUSE_LEAVE, onStage_MouseLeaveHandler);
			}
			
			_timer.reset();
		}
		
		/**************************************
		 * Handlers
		 **************************************/

		/**
		 * Handles the MouseOver Event that is dispatched from Stage.
		 * @param event
		 */
		private function onStage_MouseOverHandler(event:Event):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_OVER, onStage_MouseOverHandler);
			
			_timer.reset();
		}
		
		/**
		 * Handles the MouseLeave Event that is dispatched from Stage.
		 * @param event
		 */
		private function onStage_MouseLeaveHandler(event:Event):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_OVER, onStage_MouseOverHandler);
			
			_timer.start();
		}
		
		/**
		 * Handles the Tick Event that is dispatched from Timer.
		 * @param event
		 */
		private function onTimer_TickHandler(event:Event):void
		{
			dispatchEvent(new Event(ROTATE));
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		/**
		 * The amount of time to wait until dispatching the <code>ROTATE</code> event.
		 */
		public function get delay():int { return _timer.delay; }
		public function set delay(value:int):void
		{
			_timer.delay = value;
		}
		
	}

}