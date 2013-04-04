package com.savage.utils
{
	import com.savage.interfaces.IMeasurable;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	/**
	 * The LayoutUtil class ...
	 * @author jason.s
	 */
	public class LayoutUtil
	{
		/**
		 * Places the target object to the right of the specified obj with a margin.
		 */
		public static function placeToTheRightOf(target:DisplayObject, obj:DisplayObject, margin:Number=0):void
		{
			target.x = obj.x + measureObjectWidth(obj) + margin;
		}
		
		/**
		 * Places the target object to the left of the specified obj with a margin.
		 */
		public static function placeTheLeftOf(target:DisplayObject, obj:DisplayObject, margin:Number=0):void
		{
			target.x = obj.x - (measureObjectWidth(target) + margin);
		}
		
		/**
		 * Places the target object above the specified obj with a margin.
		 */
		public static function placeAbove(target:DisplayObject, obj:DisplayObject, margin:Number=0):void
		{
			target.y = obj.y - (measureObjectHeight(target) + margin);
		}
		
		/**
		 * Places the target object below the specified obj with a margin.
		 */
		public static function placeBelow(target:DisplayObject, obj:DisplayObject, margin:Number=0):void
		{
			target.y = obj.y + measureObjectHeight(obj) + margin;
		}
		
		/**
		 * Centers the child in the view.
		 */
		public static function centerInView(view:View, child:DisplayObject):void
		{
			centerHorzInView(view, child);
			centerVertInView(view, child);
		}
		
		/**
		 * Centers the child Vertically in the view.
		 */
		public static function centerVertInView(view:View, child:DisplayObject, offset:Number=0):void
		{
			child.y = ((view.measureHeight() - measureObjectHeight(child)) >> 1) + offset;
		}
		
		/**
		 * Centers the child horizontally in the view.
		 */
		public static function centerHorzInView(view:View, child:DisplayObject, offset:Number=0):void
		{
			child.x = ((view.measureWidth() - measureObjectWidth(child)) >> 1) + offset;
		}
		
		
		/**
		 * Measures the width of a display object. 
		 * If obj is an <code>IMeasurable</code> this gets the value of <code>measureWidth()</code>.
		 */
		public static function measureObjectWidth(obj:DisplayObject):Number
		{
			if(obj is IMeasurable)
				return IMeasurable(obj).measureWidth();
			
			if(obj is TextField) 
				return TextField(obj).getBounds(obj).width;
			
			return obj.width;
		}
		
		/**
		 * Measures the height of a display object. 
		 * If obj is an <code>IMeasurable</code> this gets the value of <code>measureHeight()</code>.
		 */
		public static function measureObjectHeight(obj:DisplayObject):Number
		{
			if(obj is IMeasurable)
				return IMeasurable(obj).measureHeight();
			
			if(obj is TextField) 
				return TextField(obj).getBounds(obj).height;
			
			return obj.height;
		}
	}
}