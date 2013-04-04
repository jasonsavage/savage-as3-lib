package com.savage.views.display 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * The Button class is almost like the SimpleButton class but uses a MovieClip as the button.
	 * Frame 1 is the upState, frame 2 is the overState, frame 3 is the downState 
	 * and hitState can be assigned to an object on the stage.
	 * @author Jason Savage
	 */
	public class ButtonMovieClip extends MovieClip
	{
		
		/**
		 * Constructor
		 */
		public function ButtonMovieClip() 
		{
			super();
			stop();
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
		}
		
		/**
		 * Handles the MouseOver Event that is dispatched from .
		 * @param event
		 */
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			gotoAndStop(2);
		}
		
		/**
		 * Handles the MouseOut Event that is dispatched from .
		 * @param event
		 */
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			gotoAndStop(1);
		}
		
		/**
		 * Handles the MouseUp Event that is dispatched from .
		 * @param event
		 */
		protected function onMouseUpHandler(event:MouseEvent):void
		{
			gotoAndStop(2);
		}
		
		/**
		 * Handles the MouseDown Event that is dispatched from .
		 * @param event
		 */
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			gotoAndStop(3);
		}
		
	}

}