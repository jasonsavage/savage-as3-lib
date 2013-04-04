package com.savage.layouts 
{
	import com.savage.views.View;
	
	/**
	 * The FrameLayout class is the base class for all layouts. 
	 * It arranges all of the children of a view at the top left corner on top of each other.
	 * @author Jason Savage
	 */
	public class LayoutBase
	{
		//Number or String
		private var _width:Object;
		private var _height:Object;
		
		//Number or String
		private var _paddingTop:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingBottom:Number = 0;
		private var _paddingLeft:Number = 0;
		
		/**
		 * Constructor
		 */
		public function LayoutBase(self:LayoutBase) 
		{ 
			if (this != self)
				throw new ArgumentError("LayoutBase is an abstract base class; therefore, you cannot call LayoutBase directly, it must be extended.");
		}
		
		/**
		 * Convenience method to set the width and height of this layout.
		 */
		public function setSize(w:Object, h:Object):void
		{
			_width = w;
			_height = h;
		}
		
		/**
		 * Convenience method to set the padding of this layout.
		 */
		public function setPadding(top:Number=0, right:Number=0, bottom:Number=0, left:Number=0):void
		{
			_paddingTop = top;
			_paddingRight = right;
			_paddingBottom = bottom;
			_paddingLeft = left;
		}
		
		/**
		 * Called to reposition all children based on their layout properties within their parent view.
		 * @param	view - The view whose children need repositioned.
		 */
		public function updateLayout(view:View):void
		{
			
		}

		/**************************************
		 * Accessors
		 **************************************/
		
		public function get width():Object { return _width; }
		public function set width(value:Object):void
		{
			_width = value;
		}
		
		public function get height():Object { return _height; }
		public function set height(value:Object):void
		{
			_height = value;
		}
		
		public function get paddingTop():Number { return _paddingTop; }
		public function set paddingTop(value:Number):void
		{
			_paddingTop = value;
		}
		
		public function get paddingRight():Number { return _paddingRight; }
		public function set paddingRight(value:Number):void
		{
			_paddingRight = value;
		}
		
		public function get paddingBottom():Number { return _paddingBottom; }
		public function set paddingBottom(value:Number):void
		{
			_paddingBottom = value;
		}
		
		public function get paddingLeft():Number { return _paddingLeft; }
		public function set paddingLeft(value:Number):void
		{
			_paddingLeft = value;
		}
		
	}

}