package com.savage.layouts 
{
	import com.savage.interfaces.IView;
	import com.savage.utils.LayoutUtil;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * The AbsoluteLayout class arranges all of the children of a view based on their layout params.
	 * @author Jason Savage
	 */
	public class AbsoluteLayout extends FrameLayout
	{
		
		/**
		 * Constructor
		 */
		public function AbsoluteLayout() { }
		
		
		override public function updateLayout(view:View):void
		{
			for (var i:int = 0; i < view.numChildren; i++)
			{
				//add padding
				var child:DisplayObject = view.getChildAt(i);
				if(child.x == 0) child.x = paddingLeft;
				if(child.y == 0) child.y = paddingTop;
				
				var childView:View = child as View;
				if (childView)
				{
					if (childView.top != null && childView.top is Number)
						childView.y = Number(childView.top) + paddingTop;
						
					if (childView.left != null && childView.left is Number)
						childView.x = Number(childView.left) + paddingLeft;
						
					if (childView.bottom != null && childView.bottom is Number)
						childView.y = (view.measureHeight() - childView.measureHeight()) - Number(childView.bottom) - paddingBottom;
					
					if (childView.right != null && childView.right is Number)
						childView.x = (view.measureWidth() - childView.measureWidth()) - Number(childView.right) - paddingRight;
					
					if (childView.horizontalCenter != null && childView.horizontalCenter is Number)
						LayoutUtil.centerHorzInView(view, childView as DisplayObject,  Number(childView.horizontalCenter));
					
					if (childView.verticalCenter != null && childView.verticalCenter is Number)
						LayoutUtil.centerVertInView(view, childView  as DisplayObject,  Number(childView.verticalCenter));
				}
			}
		}
		
	}

}