package com.savage.views.menu 
{
	import com.savage.layouts.LinearLayout;
	import com.savage.views.View;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * The AccordionMenu class has clickable tabs that expand into submenus. 
	 * @author Jason Savage
	 */
	public class AccordionMenu extends View 
	{
		private var _selectedTab:AccordionMenuTab;
		private var _selectedTabMenu:View;
		
		/**
		 * Constructor
		 */
		public function AccordionMenu() 
		{
			super();
			layout = new LinearLayout(LinearLayout.VERTICAL, 1);
			layout.setSize(200,300);
		}
		
		public function addTab( tab:AccordionMenuTab ):void
		{
			tab.addEventListener(MouseEvent.CLICK, onTab_ClickHandler);
			addChild(tab);
		}
		
		public function removeTab( tab:AccordionMenuTab ):void
		{
			tab.removeEventListener(MouseEvent.CLICK, onTab_ClickHandler);
			removeChild(tab);
			
			if (_selectedTab == tab)
				_selectedTab = null;
				
			if (_selectedTabMenu)
				removeTabMenu();
		}
		
		public function getSelectedTabMenu():View
		{
			return _selectedTabMenu;
		}
		
		/**************************************
		 * Protected
		 **************************************/
		
		protected function addTabMenu():void
		{
			_selectedTabMenu = _selectedTab.createMenu();
			_selectedTabMenu.layout.width = "100%";
			_selectedTabMenu.layout.height = measureHeight() - measureTabHeights();
			_selectedTabMenu.clipContent = true;
			
			var i:int = getChildIndex(_selectedTab);
			addChildAt(_selectedTabMenu, i + 1);
		}
		
		protected function removeTabMenu():void
		{
			if (_selectedTabMenu)
			{
				removeChild(_selectedTabMenu);
				_selectedTabMenu = null;
			}
		}
		
		/**************************************
		 * Private
		 **************************************/
		
		private function measureTabHeights():Number
		{
			var h:Number = 0;
			var len:int = numChildren;
			for (var i:int = 0; i < len; i++)
			{
				var tab:AccordionMenuTab = getChildAt(i) as AccordionMenuTab;
				h += tab.measureHeight() + LinearLayout(layout).verticalGap;
			}
			
			return h;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		protected function onTab_ClickHandler(event:MouseEvent):void
		{
			var tab:AccordionMenuTab = event.target as AccordionMenuTab;
			selectedTab = (tab != _selectedTab) ? tab : null;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get selectedTab():AccordionMenuTab { return _selectedTab; }
		public function set selectedTab(value:AccordionMenuTab):void
		{
			if (_selectedTab == value) return;
			
			//remove old menu
			if (_selectedTab)
			{
				removeTabMenu();
				_selectedTab.selected = false;
			}
			
			_selectedTab = value;
			
			//add new menu
			if (_selectedTab)
			{
				addTabMenu();
				_selectedTab.selected = true;
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}