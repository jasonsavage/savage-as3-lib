package com.savage.layouts 
{
	import com.savage.interfaces.IMeasurable;
	import com.savage.utils.LayoutUtil;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * The CenterLayout class arranges all of the children of a view at the center on top of each other.
	 * @author Jason Savage
	 */
	public class CenterLayout extends FrameLayout 
	{
		private var _horizontal:Boolean;
		private var _vertical:Boolean;
		
		/**
		 * Constructor
		 */
		public function CenterLayout(w:Object=null, h:Object=null, horizontal:Boolean=true, vertical:Boolean=true) 
		{
			super();
			
			setSize(w, h);
			_horizontal = horizontal;
			_vertical = vertical;
		}
		
		override protected function positionChild(view:View, child:DisplayObject, pt:Point):Point 
		{
			if(_horizontal)
				LayoutUtil.centerHorzInView(view, child);
			
			if(_vertical)
				LayoutUtil.centerVertInView(view, child);
			
			return pt;
		}
		
	}

}