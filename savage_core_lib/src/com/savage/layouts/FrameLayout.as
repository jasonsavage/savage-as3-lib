package com.savage.layouts 
{
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * The FrameLayout class is the base class for all layouts. 
	 * It arranges all of the children of a view at the top left corner on top of each other.
	 * @author Jason Savage
	 */
	public class FrameLayout extends LayoutBase
	{
		/**
		 * Constructor
		 */
		public function FrameLayout() 
		{
			super(this);
		}
		
		protected function getStartPoint(view:View):Point
		{
			return new Point(paddingLeft, paddingTop);
		}
		
		/**
		 * Called to reposition all children based on their layout properties within their parent view.
		 * @param	view - The view whose children need repositioned.
		 */
		override public function updateLayout(view:View):void
		{
			var pt:Point = getStartPoint(view);
			for (var i:int = 0; i < view.numChildren; i++)
			{
				pt = positionChild(view, view.getChildAt(i), pt);
			}
		}
		
		/**
		 * Called on each child to position it and returns the next point.
		 * @param	child
		 * @param	pt
		 * @return
		 */
		protected function positionChild(view:View, child:DisplayObject, pt:Point):Point
		{
			child.x = pt.x;
			child.y = pt.y;
			
			return pt;
		}
	}

}