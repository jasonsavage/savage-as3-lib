package com.savage.views.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class RevMovieClip extends MovieClip
	{
		/**
		 * Constructor
		 */
		public function RevMovieClip() 
		{
			super();
		}
		
		public function reverse():void
		{
			addEventListener(Event.ENTER_FRAME, playInReverse);
		}
		
		override public function stop():void 
		{
			removeEventListener(Event.ENTER_FRAME, playInReverse);
			super.stop();
		}
		
		private function playInReverse(event:Event):void
		{
			prevFrame();
		}
	}

}