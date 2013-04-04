package com.savage.views.menu
{
	import com.savage.business.SelectedItemsWatcher;
	import com.savage.interfaces.ISelectableItem;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	
	/**
	 * The Menu class ...
	 * @author jason.s
	 */
	public class Menu extends View
	{
		private var _dataProvider:Array;
		private var _itemsWatcher:SelectedItemsWatcher;
		
		/**
		 * Constructor
		 */
		public function Menu()
		{
			super();
			_itemsWatcher = new SelectedItemsWatcher();
			_itemsWatcher.addEventListener(SelectedItemsWatcher.CHANGE, onWatcher_ChangeHandler);
			_itemsWatcher.addEventListener(SelectedItemsWatcher.NO_CHANGE, onWatcher_ChangeHandler);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if(child is ISelectableItem)
				_itemsWatcher.addItem(child as ISelectableItem);
			
			return super.addChildAt(child, index);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = super.removeChildAt(index);
			
			if(child is ISelectableItem)
				_itemsWatcher.removeItem(child as ISelectableItem);
			
			return child;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		private function onWatcher_ChangeHandler(event:Event):void
		{
			dispatchEvent(event);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get watcher():SelectedItemsWatcher { return _itemsWatcher; }

		public function get selectedIndex():int { return _itemsWatcher.selectedIndex; }
		public function set selectedIndex(value:int):void
		{
			_itemsWatcher.selectedIndex = value;
		}
		
	}
}