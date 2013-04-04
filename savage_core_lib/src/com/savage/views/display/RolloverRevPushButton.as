package com.savage.views.display
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	
	public class RolloverRevPushButton extends RevMovieClip
	{
		public static const ROLLOUT_DELAY:int = 100;
		
		private var _timeoutId:int;
		private var _selected:Boolean;
		private var _rolloverEndFrame:int;
		private var _selectedFrame:int;
		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void
		{
			_selected = value;
			
			if(value)
				gotoAndStop(_selectedFrame);
			else
				gotoAndStop(1);
		}
		
		
		/**
		 * Constructor
		 */
		public function RolloverRevPushButton() 
		{
			super();
			addFrameScript(0, upFrameScript);
		}
		
		public function initialize(rolloverEndFrame:int, selectedFrame:int):void
		{
			_rolloverEndFrame = rolloverEndFrame-1;
			_selectedFrame = selectedFrame-1;
			
			buttonMode = true;
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_OVER, on_MouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, on_MouseOutHandler);
			
			//add frame scripts
			addFrameScript(_rolloverEndFrame, rolloverEndFrameScript);
			addFrameScript(_selectedFrame, selectedFrameScript);
		}
		
		public function playRollover():void
		{
			if (currentFrame == _rolloverEndFrame) return;
			play();
		}
		
		public function playRollout():void
		{
			if (currentFrame == _selectedFrame)
				gotoAndStop(_rolloverEndFrame);
			
			reverse();
		}
		
		protected function upFrameScript():void
		{
			stop();
		}
		
		protected function rolloverEndFrameScript():void
		{
			stop();
		}
		
		protected function selectedFrameScript():void
		{
			stop();
		}
		
		
		/**************************************
		 * Handler
		 **************************************/
		
		/**
		 * Handles the MouseOver Event that is dispatched from HitArea.
		 * @param event
		 */
		protected function on_MouseOverHandler(event:MouseEvent):void
		{
			if (selected) return;

			clearTimeout(_timeoutId);
			playRollover();
		}
		
		/**
		 * Handles the MouseOut Event that is dispatched from HitArea.
		 * @param event
		 */
		protected function on_MouseOutHandler(event:MouseEvent):void
		{
			if (selected) return;
			
			clearTimeout(_timeoutId);
			_timeoutId = setTimeout(on_MouseOutTimeout, ROLLOUT_DELAY);
		}
		
		protected function on_MouseOutTimeout():void
		{
			playRollout();
		}
		
	}

}