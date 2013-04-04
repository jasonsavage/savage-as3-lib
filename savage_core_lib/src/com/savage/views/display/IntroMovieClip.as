package com.savage.views.display
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	//com.savage.ui.IntroMovieClip
	public class IntroMovieClip extends MovieClip
	{
		/**
		 * Constructor
		 */
		public function IntroMovieClip() 
		{
			super();
			
			addFrameScript(0, frame1);
			addFrameScript(1, frame2);
			addFrameScript(totalFrames-1, frameLast);
		}
		
		public function playIntro():void
		{
			gotoAndPlay(2);
		}
		
		public function reset():void
		{
			gotoAndStop(1);
		}
		
		protected function frame1():void
		{
			stop();
			visible = false;
		}
		
		protected function frame2():void
		{
			visible = true;
		}
		
		protected function frameLast():void
		{
			stop();
		}
	}

}