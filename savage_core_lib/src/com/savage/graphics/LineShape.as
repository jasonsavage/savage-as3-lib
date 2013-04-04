package com.savage.graphics 
{
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.styles.LineStyle;
	import com.savage.utils.PointUtil;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class LineShape extends DrawnShape
	{
		private var _length:Number;		
		private var _angle:Number;
		private var _lineStyle:LineStyle;
		
		private var _dashLength:Number;
		private var _gapLength:Number;
		
		/**
		 * Constructor
		 */
		public function LineShape(length:Number = 10, thickness:int = 1, color:uint = 0, angle:Number=0, dashLength:Number = 0, gapLength:Number=0) 
		{
			super(10, 10);
			
			_length 	= length;
			_angle 		= angle;
			_dashLength = dashLength;
			_gapLength 	= gapLength;
			
			_lineStyle = new LineStyle(thickness, color);
		}
		
		override public function clone():DrawnShape
		{
			var line:LineShape = new LineShape(_length, _lineStyle.thickness, _lineStyle.color, _angle, _dashLength, _gapLength);
			line.drawnWidth = drawnWidth;
			line.drawnHeight = drawnHeight;
			return line;
		}
		
		override protected function beginDraw():void 
		{
			super.beginDraw();
			
			graphics.clear();
			_lineStyle.applyLine(graphics);
		}
		
		override protected function draw():void 
		{
			var start:Point = new Point(_lineStyle.thickness * 0.5, _lineStyle.thickness * 0.5); //offset because of the way flash draws
			
			if (_dashLength > 0 && _gapLength == 0)
				_gapLength = _dashLength;
			
			if (_dashLength > 0)
			{
				//draw dashed
				var len:int = _dashLength;
				var drawing:Boolean = true;
				var next:Point = start;
				
				graphics.moveTo(start.x, start.y);
				while (len < _length)
				{
					next = PointUtil.getPointAtAngle(start, _angle, len);
					
					if (drawing)
					{
						graphics.lineTo(next.x, next.y);
						len += _dashLength;
					}
					else
					{
						graphics.moveTo(next.x, next.y);
						len += _gapLength;
					}
					
					drawing = !drawing;
				}
			}
			else
			{
				//draw a solid line
				var end:Point = PointUtil.getPointAtAngle(start, _angle, _length);
				
				graphics.moveTo(start.x, start.y);
				graphics.lineTo(end.x, end.y);
			}
			
			drawnHeight = height;
			drawnWidth = width;
			
			super.draw();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get dashLength():Number { return _dashLength; }
		public function set dashLength(value:Number):void
		{
			_dashLength = value;
			invalidateProperties();
		}
		
		public function get gapLength():Number { return _gapLength; }
		public function set gapLength(value:Number):void
		{
			_gapLength = value;
			invalidateProperties();
		}
		
		public function get length():Number { return _length; }
		public function set length(value:Number):void
		{
			_length = value;
			invalidateProperties();
		}
		
		public function get lineStyle():LineStyle { return _lineStyle; }
		public function set lineStyle(value:LineStyle):void
		{
			_lineStyle = value;
			invalidateProperties();
		}
		
		public function get angle():Number { return _angle; }
		public function set angle(value:Number):void
		{
			_angle = value;
			invalidateProperties();
		}
		
	}

}