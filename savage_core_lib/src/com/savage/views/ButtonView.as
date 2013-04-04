package com.savage.views 
{
	import com.savage.graphics.styles.SolidFillStyle;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * The ButtonView class uses its children as the up(0), over(1), and down(2) state of this view.
	 * @author Jason Savage
	 */
	public class ButtonView extends StackView
	{
		
		/**
		 * Constructor
		 */
		public function ButtonView() 
		{
			super();
			background = new SolidFillStyle(0,0);
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
			selectedIndex = 0;
		}

		protected function onMouseHandler(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_OUT :
					selectedIndex = 0;
				break;
				
				case MouseEvent.MOUSE_OVER :
				case MouseEvent.MOUSE_UP :
					selectedIndex = 1;
				break;
				
				case MouseEvent.MOUSE_DOWN :
					selectedIndex = 2;
				break;
			}
		}

		public function hasChildAt(index:int):Boolean 
		{ 
			return (numChildren > index);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get upStateView():DisplayObject 
		{ 
			return hasChildAt(0)? getChildAt(0) : null;
		}
		public function set upStateView(value:DisplayObject):void
		{ 
			if(hasChildAt(0))
				removeChildAt(0);
			
			addChildAt(value, 0);
		}
		
		public function get overStateView():DisplayObject 
		{ 
			return hasChildAt(1)? getChildAt(1) : null;
		}
		public function set overStateView(value:DisplayObject):void
		{ 
			if(hasChildAt(1))
				removeChildAt(1);
			
			addChildAt(value, 1);
		}
		
		public function get downStateView():DisplayObject 
		{ 
			return hasChildAt(2)? getChildAt(2) : null;
		}
		public function set downStateView(value:DisplayObject):void
		{ 
			if(hasChildAt(2))
				removeChildAt(2);
			
			addChildAt(value, 2);
		}

	}

}