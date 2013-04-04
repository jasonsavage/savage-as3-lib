package com.savage.views.menu 
{
	import com.savage.graphics.styles.FillStyle;
	import com.savage.graphics.styles.GradientFillStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.interfaces.ISelectableItem;
	import com.savage.views.View;
	
	import mx.graphics.SolidColor;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class AccordionMenuTab extends View implements ISelectableItem
	{
		private var _selected:Boolean;
		
		
		/**
		 * Constructor
		 */
		public function AccordionMenuTab() 
		{
			super();
			layout.width = "100%";
			layout.height = 20;
			background = new SolidFillStyle(0xDB5823);
			buttonMode = true;
		}
		
		public function createMenu():View
		{
			var view:View = new View();
			view.background = new SolidFillStyle(0x999999);
			return view;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
	}

}