package com.savage.views.display
{
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class RolloverRevButton extends RevMovieClip
	{
		public static const ROLLOUT_DELAY:int = 100;
		
		private var _timeoutId:int;
		private var _rolloverEndFrame:int;
		
		/**
		 * Constructor
		 */
		public function RolloverRevButton() 
		{
			super();
			addFrameScript(0, upFrameScript);
		}
		
		public function initialize(rolloverEndFrame:int):void
		{
			_rolloverEndFrame = rolloverEndFrame-1;
			
			buttonMode = true;
			mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_OVER, on_MouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, on_MouseOutHandler);
			
			//add frame scripts
			addFrameScript(_rolloverEndFrame, rolloverEndFrameScript);
		}
		
		public function playRollover():void
		{
			if (currentFrame == _rolloverEndFrame) return;
			stop();
			play();
		}
		
		public function playRollout():void
		{
			if (currentFrame == 0) return
			stop();
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
		
		
		/**************************************
		 * Handler
		 **************************************/
		
		/**
		 * Handles the MouseOver Event that is dispatched from HitArea.
		 * @param event
		 */
		protected function on_MouseOverHandler(event:MouseEvent):void
		{
			clearTimeout(_timeoutId);
			playRollover();
		}
		
		/**
		 * Handles the MouseOut Event that is dispatched from HitArea.
		 * @param event
		 */
		protected function on_MouseOutHandler(event:MouseEvent):void
		{
			clearTimeout(_timeoutId);
			_timeoutId = setTimeout(on_MouseOutTimeout, ROLLOUT_DELAY);
		}
		
		protected function on_MouseOutTimeout():void
		{
			playRollout();
		}
		
	}

}