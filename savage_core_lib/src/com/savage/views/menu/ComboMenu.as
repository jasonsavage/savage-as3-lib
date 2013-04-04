package com.savage.views.menu 
{
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.LinearLayout;
	import com.savage.views.View;
	
	import flash.events.MouseEvent;
	
	/**
	 * The ComboMenu class that contains a button and a View that is dynamicly added at removed from this view when the user clikcs the button
	 * @author Jason Savage
	 */
	public class ComboMenu extends View 
	{
		private var _menuHeight:Number = 100;
		private var _expandOnRollover:Boolean;
		
		//children
		private var _tab:View;
		private var _menu:View;
		
		/**
		 * Constructor
		 */
		public function ComboMenu() 
		{
			super();
			layout = new LinearLayout(LinearLayout.VERTICAL, 2);
			layout.width = 100;
			background = new SolidFillStyle(0xffffff, 0.1);
		}
		
		public function getTab():View
		{
			return _tab;
		}
		
		public function getList():View
		{
			return _menu;
		}
		
		public function expand():void
		{
			addMenu();
		}
		
		public function contract():void
		{
			removeMenu();
		}
		
		/**************************************
		 * Protected
		 **************************************/
		
		protected function createTab():View
		{
			var view:View = new View();
			view.layout.height = 20;
			view.background = new SolidFillStyle();
			view.buttonMode = true;
			
			return view;
		}
		
		protected function createMenu():View
		{
			var view:View = new View();
			view.layout = new LinearLayout(LinearLayout.VERTICAL, 1);
			view.background = new SolidFillStyle(0, 0.5);
			
			return view;
		}
		
		/**************************************
		 * Private
		 **************************************/
		
		private function addMenu():void
		{
			if (_menu) return;
			
			_menu = createMenu();
			_menu.layout.setSize("100%", _menuHeight);
			addChild( _menu );
			
			addEventListener(MouseEvent.ROLL_OUT, onMouse_RolloutHandler);
		}
		
		private function removeMenu():void
		{
			if (!_menu) return;
			
			removeChild(_menu);
			_menu = null;
			
			removeEventListener(MouseEvent.ROLL_OUT, onMouse_RolloutHandler);
		}
		
		/**************************************
		 * Overrides
		 **************************************/
		
		override protected function initialize():void 
		{
			super.initialize();
			
			if (_expandOnRollover)
				_tab.addEventListener(MouseEvent.ROLL_OVER, onButton_clickHandler);
			else
				_tab.addEventListener(MouseEvent.CLICK, onButton_clickHandler);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add button
			_tab = createTab();
			_tab.layout.width = "100%";
			addChild(_tab);
		}
		
		
		/**************************************
		 * Handlers
		 **************************************/
		
		protected function onButton_clickHandler(event:MouseEvent):void
		{
			//toggle
			if (!_menu)
				addMenu();
			else
				removeMenu();
		}
		
		protected function onMouse_RolloutHandler(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.ROLL_OUT, onMouse_RolloutHandler);
			removeMenu();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get menuHeight():Number { return _menuHeight; }
		public function set menuHeight(value:Number):void
		{
			_menuHeight = value;
		}
		
		public function get expandOnRollover():Boolean { return _expandOnRollover; }
		public function set expandOnRollover(value:Boolean):void
		{
			_expandOnRollover = value;
		}
		
	}

}