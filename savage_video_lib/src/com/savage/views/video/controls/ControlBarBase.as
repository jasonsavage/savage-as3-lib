package com.savage.views.video.controls
{
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.LinearLayout;
	import com.savage.views.View;
	import com.savage.views.video.VideoDisplay;
	
	import flash.events.Event;
	
	
	/**
	 * The VideoControlBarBase class ...
	 * @author jason.s
	 */
	public class ControlBarBase extends View
	{
		private var _source:VideoDisplay;
		
		/**
		 * Constructor
		 */
		public function ControlBarBase()
		{
			super();
			
			layout = new LinearLayout(LinearLayout.HORIZONTAL, 0, true);
			layout.width = "100%";
			layout.height = 20;
			background = new SolidFillStyle(0,0.8);
			bottom = 0;
		}
		
		/**
		 * Rests all controls to there base values. 
		 * Auto-called when the source value is changed.
		 */
		public function reset():void
		{
			
		}
		
		protected function addListeners():void {}
		protected function removeListeners():void {}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if(_source)
			{
				addListeners();
				reset();
			}
			
		}
		
		/**************************************
		 * Accessors
		 **************************************/

		public function get source():VideoDisplay { return _source; }
		public function set source(value:VideoDisplay):void
		{
			if (_source == value)
				return;
			
			if(_source)
				removeListeners();
			
			_source = value;
			
			if(initialized)
			{
				if(_source)
					addListeners();
				
				//reset controls
				reset();
			}
			
			//dispatch change event
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}