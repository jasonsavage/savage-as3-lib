package com.savage.views 
{
	import com.savage.layouts.LinearLayout;
	import com.savage.views.scroll.ScrollBarView;

	/**
	 * ...
	 * @author 
	 */
	public class ScrollPane extends View 
	{
		private var _contentClass:Class = View;
		private var _scrollClass:Class = ScrollBarView;
		
		//children
		private var _content:View;
		private var _scrollbar:ScrollBarView;
		
		/**
		 * Constructor
		 */
		public function ScrollPane() 
		{
			super();
			layout = new LinearLayout(LinearLayout.HORIZONTAL);
		}
		
		public function getScrollBar():ScrollBarView
		{
			return _scrollbar;
		}
		
		public function getContentPane():View
		{
			return _content;
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add content
			_content = new _contentClass();
			_content.layout.setSize("100%","100%");
			_content.clipContent = true;
			addChild(_content);
			
			//add scrollbar
			_scrollbar = new _scrollClass();
			_scrollbar.layout.height = "100%";
			addChild(_scrollbar);
			
			_scrollbar.source = _content;
		}
		
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get contentClass():Class { return _contentClass; }
		public function set contentClass(value:Class):void
		{
			_contentClass = value;
		}
		
		public function get scrollClass():Class { return _scrollClass; }
		public function set scrollClass(value:Class):void
		{
			_scrollClass = value;
		}
	}

}