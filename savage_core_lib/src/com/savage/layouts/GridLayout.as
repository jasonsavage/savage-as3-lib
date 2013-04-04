package com.savage.layouts 
{
	import com.savage.views.View;
	import com.savage.interfaces.IMeasurable;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class GridLayout extends LinearLayout
	{
		public static const HORIZONTAL_TILE:String = "horizontal";
		public static const VERTICAL_TILE:String = "vertical";
		
		private var _columns:int = 3;
		private var _colCounter:int;
		
		public function get columns():int { return _columns; }
		public function set columns(value:int):void
		{
			_columns = (value > 0) ? value : 1;
		}
		
		/**
		 * Constructor
		 */
		public function GridLayout(orientation:String="", columns:int=3, gap:Number=0) 
		{
			_columns = columns;
			
			this.orientation 	= (orientation != "") ? orientation : HORIZONTAL_TILE;
			this.horizontalGap 	= gap;
			this.verticalGap 	= gap;
		}
		
		protected function getNextHorzPoint(view:View, child:DisplayObject, pt:Point):Point 
		{
			var w:Number = (child is IMeasurable) ? IMeasurable(child).measureWidth() : child.width;
			var h:Number = (child is IMeasurable) ? IMeasurable(child).measureHeight() : child.height;
			
			pt.x += (w + horizontalGap);
			_colCounter++;
					
			if(_colCounter >= _columns)
			{
				pt.x = getStartPoint(view).x;
				pt.y += (h + verticalGap);
				_colCounter = 0;
			}
			return pt;
		}
		
		protected function getNextVertPoint(view:View, child:DisplayObject, pt:Point):Point 
		{
			var w:Number = (child is IMeasurable) ? IMeasurable(child).measureWidth() : child.width;
			var h:Number = (child is IMeasurable) ? IMeasurable(child).measureHeight() : child.height;
			
			pt.y += (h + verticalGap);
			_colCounter++;
				
			if(_colCounter >= columns)
			{
				pt.y = getStartPoint(view).y;
				pt.x += (w + horizontalGap);
				_colCounter = 0;
			}
			
			return pt;
		}
	}

}