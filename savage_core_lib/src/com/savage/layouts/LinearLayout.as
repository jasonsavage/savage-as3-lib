package com.savage.layouts 
{
	import com.savage.utils.LayoutUtil;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * The LinearLayout class positions it's children in a row depending on the specified orientation.
	 * LinearLayout ignores any layout params for each child.
	 */
	public class LinearLayout extends FrameLayout
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _orientation:String 	= VERTICAL;
		private var _horizontalGap:Number 	= 0;
		private var _verticalGap:Number 	= 0;
		private var _alignCenter:Boolean;
		
		private var _lastChild:DisplayObject;
		
		/**
		 * Constructor
		 */
		public function LinearLayout(orientation:String="vertical", gap:Number=0, alignCenter:Boolean=false) 
		{
			_orientation = orientation;
			_alignCenter = alignCenter;
			
			if (_orientation == HORIZONTAL)
				_horizontalGap = gap;
			
			if (_orientation == VERTICAL)
				_verticalGap = gap;
		}
		
		override protected function positionChild(view:View, child:DisplayObject, pt:Point):Point 
		{
			if (_orientation == HORIZONTAL)
			{
				if(_lastChild)
					LayoutUtil.placeToTheRightOf(child, _lastChild, horizontalGap);
				else
					child.x = pt.x;
				
				if (_alignCenter)
					LayoutUtil.centerVertInView(view, child);
				else
					child.y = pt.y;
				
				_lastChild = child;
			}
				
			if (_orientation == VERTICAL)
			{
				if(_lastChild)
					LayoutUtil.placeBelow(child, _lastChild, _verticalGap);
				else
					child.y = pt.y;
				
				if (_alignCenter)
					LayoutUtil.centerHorzInView(view, child);
				else
					child.x = pt.x;
			}
			
			_lastChild = child;
			
			return pt;
		}
		
		override public function updateLayout(view:View):void
		{
			super.updateLayout(view);
			_lastChild = null;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get orientation():String { return _orientation; }
		public function set orientation(value:String):void
		{
			_orientation = value;
		}
		
		public function get horizontalGap():Number { return _horizontalGap; }
		public function set horizontalGap(value:Number):void
		{
			_horizontalGap = value;
		}
		
		public function get verticalGap():Number { return _verticalGap; }
		public function set verticalGap(value:Number):void
		{
			_verticalGap = value;
		}
		
		public function get alignCenter():Boolean { return _alignCenter; }
		public function set alignCenter(value:Boolean):void
		{
			_alignCenter = value;
		}
	}

}