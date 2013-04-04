package com.savage.views 
{
	import com.savage.layouts.FrameLayout;
	import com.savage.styles.ButtonStyle;
	
	import flash.events.MouseEvent;
	
	/**
	 * The ButtonBase class is the base class for all button components, 
	 * defining properties and methods that are common to all buttons.
	 * @author Jason Savage
	 */
	public class ButtonBase extends View
	{
		protected var _upStateView:View;
		protected var _overStateView:View;
		protected var _downStateView:View;
		
		private var _currentView:View;
		
		/**
		 * Constructor
		 */
		public function ButtonBase(self:ButtonBase) 
		{
			super();
			
			if (this != self)
				throw new ArgumentError("ButtonBase is an abstract base class; therefore, you cannot call ButtonBase directly.");
			
			layout = new FrameLayout();
			
			//set default styles
			setStyleDefinition(new ButtonStyle());
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseHandler);
			addEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseHandler);
			buttonMode = true;
			mouseChildren = false;
			
			//show up state
			setCurrentView(_upStateView);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//create up state
			_upStateView = createUpStateView();
			
			//create over state
			_overStateView = createOverStateView();
			
			//create down state
			_downStateView = createDownStateView();
		}
		
		protected function createUpStateView():View
		{
			return new View();
		}
		
		protected function createOverStateView():View
		{
			return new View();
		}
		
		protected function createDownStateView():View
		{
			return new View();
		}
		
		protected function onMouseHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_OUT :
					setCurrentView( _upStateView );
				break;
				
				case MouseEvent.MOUSE_OVER :
				case MouseEvent.MOUSE_UP :
					setCurrentView( _overStateView );
				break;
				
				case MouseEvent.MOUSE_DOWN :
					setCurrentView( _downStateView );
				break;
			}
		}
		
		protected function setCurrentView(view:View):void
		{
			suppressInvalidateOnAddRemoveChild = true;
			
			if ( _currentView && contains(_currentView) )
				removeChild( _currentView );
				
			_currentView = view;
			addChild(_currentView);
			
			_currentView.updateProperties();
			_currentView.updateDisplayList();
			
			suppressInvalidateOnAddRemoveChild = false;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get upStateView():View { return _upStateView; }
		public function get overStateView():View { return _overStateView; }
		public function get downStateView():View { return _downStateView; }

	}

}