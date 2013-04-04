package com.savage.views 
{
	import com.savage.interfaces.ISelectableItem;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PushButtonView extends ButtonView implements ISelectableItem
	{
		private var _selected:Boolean;
		private var _disableToggle:Boolean;
		
		/**
		 * Constructor
		 */
		public function PushButtonView() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			addEventListener(MouseEvent.CLICK, onMouseHandler);
		}
		
		override protected function onMouseHandler(event:MouseEvent):void 
		{
			if(!_selected)
				super.onMouseHandler(event);
			
			if (!_disableToggle)
			{
				if (event.type == MouseEvent.CLICK)
					selected = !selected;
			}
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void
		{
			_selected = value;
			
			if (_selected)
				selectedIndex = 3;
			else
				selectedIndex = 0;
		}
		
		public function get disableToggle():Boolean { return _disableToggle; }
		public function set disableToggle(value:Boolean):void
		{
			_disableToggle = value;
		}
		
		public function get selectedStateView():DisplayObject 
		{ 
			return hasChildAt(3)? getChildAt(3) : null;
		}
		public function set selectedStateView(value:DisplayObject):void
		{ 
			if(hasChildAt(3))
				removeChildAt(3);
			
			addChildAt(value, 3);
		}
	}

}