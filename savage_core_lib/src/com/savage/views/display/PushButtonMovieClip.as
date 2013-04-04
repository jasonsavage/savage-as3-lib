package com.savage.views.display 
{
	import com.savage.interfaces.ISelectableItem;
	import flash.events.MouseEvent;
	
	/**
	 * The PushButton class adds frame 4 as the selectedState.
	 * @author Jason Savage
	 */
	public class PushButtonMovieClip extends ButtonMovieClip implements ISelectableItem
	{
		private var _selected:Boolean;
		private var _toggle:Boolean = true;
		
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void
		{
			_selected = value;
			
			if (selected)
				gotoAndStop(4);
			else
				gotoAndStop(1);
		}
		
		public function get toggle():Boolean { return _toggle; }
		public function set toggle(value:Boolean):void
		{
			_toggle = value;
		}
		
		
		
		/**
		 * Constructor
		 */
		public function PushButtonMovieClip() 
		{
			super();
			
			addEventListener(MouseEvent.CLICK, onMouseClickHandler);
		}
		
		/**
		 * Handles the MouseOver Event that is dispatched from .
		 * @param event
		 */
		protected function onMouseClickHandler(event:MouseEvent):void
		{
			if(_toggle)
				selected = !selected;
		}
		
		override protected function onMouseOverHandler(event:MouseEvent):void 
		{
			if(!selected)
				super.onMouseOverHandler(event);
		}
		
		override protected function onMouseOutHandler(event:MouseEvent):void 
		{
			if(!selected)
				super.onMouseOutHandler(event);
		}
		
		override protected function onMouseDownHandler(event:MouseEvent):void 
		{
			if(!selected)
				super.onMouseDownHandler(event);
		}
		
		override protected function onMouseUpHandler(event:MouseEvent):void 
		{
			if(!selected)
				super.onMouseUpHandler(event);
		}
		
	}

}