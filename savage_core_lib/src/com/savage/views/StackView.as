package com.savage.views
{
	import com.savage.interfaces.IStackViewSlide;
	import com.savage.layouts.FrameLayout;
	import com.savage.utils.MathUtil;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * The StackView class stacks all of it's children on top of each other, where only one child at a time is visible. 
	 * When a different index or child is set, the old child is hidden and the new child is shown. 
	 * 
	 * @author Jason Savage
	 */
	public class StackView extends View
	{
		/**************************************
		 * Properties
		 **************************************/
		
		private var _selectedIndex:int = -1;
		
		/**
		 * Constructor
		 */
		public function StackView() 
		{
			super();
			layout = new FrameLayout();
		}
		
		/**************************************
		 * Private / Protected
		 **************************************/
		
		protected function setChildSelected(child:DisplayObject, index:int, array:Array):void 
		{
			if (_selectedIndex == index)
			{
				if (!child.visible)
				{
					if (child is IStackViewSlide)
						IStackViewSlide(child).show();
					else
						child.visible = true;
				}
			}
			else
			{
				if (child.visible)
				{
					if (child is IStackViewSlide)
						IStackViewSlide(child).hide();
					else
						child.visible = false;
				}
			}
		}
		
		override public function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			var children:Array = getChildren();
			children.forEach(setChildSelected);
		}

		/**************************************
		 * Accessors
		 **************************************/
		
		public function get selectedChild():DisplayObject 
		{ 
			if (_selectedIndex == -1)
				return null;
			return getChildAt(_selectedIndex);
		}
		public function set selectedChild(value:DisplayObject):void 
		{
			selectedIndex = contains(value) ? getChildIndex(value) : -1;
		}
		
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value:int):void 
		{
			if (_selectedIndex == value) return;
			
			value = MathUtil.limitWrap(value, 0, (numChildren - 1) );
			_selectedIndex = value;
			
			updateDisplayList();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
	
}