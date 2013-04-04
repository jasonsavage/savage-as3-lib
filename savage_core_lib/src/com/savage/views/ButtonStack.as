package com.savage.views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * The ButtonStack class ...
	 * @author jason.s
	 */
	public class ButtonStack extends StackView
	{
		/**
		 * Constructor
		 */
		public function ButtonStack()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			addEventListener(MouseEvent.CLICK, on_ClickHandler);
			
			selectedIndex = 0;
		}
		
		protected function on_ClickHandler(event:MouseEvent):void
		{
			selectedIndex++;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
}