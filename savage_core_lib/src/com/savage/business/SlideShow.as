package com.savage.business
{
	import com.savage.views.StackView;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**
	 * The SlideShow class ...
	 * @author jason.s
	 */
	public class SlideShow extends EventDispatcher
	{
		public static const DEFAULT_DELAY:int = 3000;
		
		/**************************************
		 * Properties
		 **************************************/
		
		private var _reverse:Boolean;
		private var _autoStagePlayPause:Boolean;
		
		private var _timer:Timer;
		private var _delay:int = DEFAULT_DELAY;
		
		private var _source:StackView;
		
		/**
		 * Constructor
		 */
		public function SlideShow()
		{
			super();
			
			_timer = new Timer( _delay );
			_timer.addEventListener(TimerEvent.TIMER, onTimer_TickHandler);
		}
		
		/**
		 * Starts the slide show at the current child.
		 */
		public function play():void
		{
			if (_source)
				_timer.start();
		}
		
		/**
		 * Stops the slide show at the current child.
		 */
		public function stop():void
		{
			if(_timer.running)
				_timer.reset();
		}
		
		/**
		 * Stops the slide show and returns to the first slide.
		 */
		public function reset():void
		{
			stop();
			
			if(_source)
				changeSourceIndex(0);
		}
		
		/**
		 * Restarts the slideshow from the current slide
		 */
		public function restart():void
		{
			stop();
			play();
		}
		
		public function gotoSlide(index:int):void
		{
			if(_source)
				changeSourceIndex(index);
		}
		
		/**
		 * Steps forward 1 child. 
		 * If at the end of the display list, calling this will goto the first child.
		 */
		public function gotoNextSlide():void
		{
			if(_source)
				changeSourceIndex(_source.selectedIndex + 1);
		}
		
		/**
		 * Steps backwards 1 child. 
		 * If at the beginning of the display list, calling this will goto the last child.
		 */
		public function gotoPreviousSlide():void
		{
			if(_source)
				changeSourceIndex(_source.selectedIndex - 1);
		}
		
		private function changeSourceIndex(index:int):void
		{
			if(index == _source.selectedIndex) return;
			
			_source.selectedIndex = index;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**************************************
		 * Protected / Private
		 **************************************/
		
		private function addStageListeners():void
		{
			var sourceStage:Stage = _source.stage;
			if(sourceStage)
			{
				sourceStage.addEventListener(MouseEvent.MOUSE_OVER, onStage_MouseHandler);
				sourceStage.addEventListener(Event.MOUSE_LEAVE, onStage_MouseHandler);
			}
		}
		
		private function removeStageListeners():void
		{
			var sourceStage:Stage = _source.stage;
			if(sourceStage)
			{
				sourceStage.removeEventListener(MouseEvent.MOUSE_OVER, onStage_MouseHandler);
				sourceStage.removeEventListener(Event.MOUSE_LEAVE, onStage_MouseHandler);
			}
		}	
		
		/**************************************
		 * Handlers
		 **************************************/
		
		/**
		 * Handles the Tick Event that is dispatched from Timer.
		 * @param event
		 */
		private function onTimer_TickHandler(event:TimerEvent):void
		{
			if (_reverse)
				gotoPreviousSlide();
			else
				gotoNextSlide();
		}
		
		/**
		 * Handles the Mouse event that is dispatched from Stage.
		 */
		protected function onStage_MouseHandler(event:Event):void
		{
			if(event.type == MouseEvent.MOUSE_OVER)
				stop();
			
			if(event.type == Event.MOUSE_LEAVE)
				play();
		}	
		
		/**************************************
		 * Accessor
		 **************************************/
		
		public function get delay():int
		{
			return _timer.delay;
		}
		public function set delay(value:int):void
		{
			_timer.delay = value;
		}
		
		public function get reverse():Boolean { return _reverse; }
		public function set reverse(value:Boolean):void
		{
			_reverse = value;
		}
		
		public function get source():StackView { return _source; }
		public function set source(value:StackView):void
		{
			_source = value;
			stop();
		}
		
		public function get autoStagePlayPause():Boolean { return _autoStagePlayPause; }
		public function set autoStagePlayPause(value:Boolean):void
		{
			if(_autoStagePlayPause == value) return;
			
			_autoStagePlayPause = value;
			
			if(_autoStagePlayPause)
				addStageListeners();
			else
				removeStageListeners();
		}	
		
	}
}