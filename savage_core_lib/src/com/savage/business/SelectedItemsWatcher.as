package com.savage.business 
{
	import com.savage.interfaces.ISelectableItem;
	import com.savage.model.data.Iterator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="chnage", type="flash.events.Event")]
	[Event(name="noChange", type="flash.events.Event")]
	
	/**
	 * ...
	 * @author ...
	 */
	public class SelectedItemsWatcher extends EventDispatcher 
	{
		public static const NO_CHANGE:String = "noChange";
		public static const CHANGE:String = "change";
		
		private var _items:Vector.<ISelectableItem>;
		private var _selectedIndex:int = 0;
		
		/**
		 * Constructor
		 */
		public function SelectedItemsWatcher(...args) 
		{
			super();
			
			_items = new Vector.<ISelectableItem>();
			var i:Iterator = new Iterator(args);
			while (i.hasNext())
				_items.push( i.next() );
			
			updateSelectedIndex();
		}
		
		public function getItemAt(index:int):ISelectableItem
		{
			return _items[index];
		}
		
		public function getItemIndex(item:ISelectableItem):int
		{
			return _items.indexOf(item);
		}
		
		public function addItem(item:ISelectableItem):void
		{
			_items.push( item );
			updateSelectedIndex();
		}
		
		public function removeItem(item:ISelectableItem):void
		{
			removeItemAt( _items.indexOf(item) );
		}
		
		public function removeItemAt(index:int):void
		{
			_items.splice(index, 1);
			updateSelectedIndex();
		}
		
		public function removeAllItems():void
		{
			selectedItem.selected = false;
			_items.length = 0;
		}
		
		protected function updateSelectedIndex():void
		{
			for(var i:int = 0; i < _items.length; i++)
				_items[i].selected = (i == _selectedIndex);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get length():int
		{
			return _items.length;
		}
		
		public function get selectedItem():ISelectableItem { return _items[_selectedIndex]; }
		public function set selectedItem(value:ISelectableItem):void
		{
			selectedIndex = _items.indexOf(value);
		}
		
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value:int):void
		{
			if (_selectedIndex == value)
			{
				dispatchEvent(new Event(NO_CHANGE));
			}
			else
			{
				_selectedIndex = value;
			
				updateSelectedIndex();
				
				dispatchEvent(new Event(CHANGE));
			}
		}
		
	}

}