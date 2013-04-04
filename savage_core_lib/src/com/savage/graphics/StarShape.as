package com.savage.graphics 
{
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	import flash.geom.Point;

	/**
	 * ...
	 * @author Jason Savage
	 */
	public class StarShape extends SolidShape
	{
		private var _points:int;
		private var _innerRadius:int;
		private var _radius:int;
		private var _center:Boolean;
		
		
		/**
		 * Constructor
		 */
		public function StarShape(radius:Number=10, innerRadius:Number=5, points:int = 5, color:uint = 0, center:Boolean=false) 
		{
			_radius = radius;
			_innerRadius = innerRadius;
			_points = (points > 4) ? points : 5;
			_center = center;
			
			super(radius, radius, new SolidFillStyle(color));
		}
		
		override protected function draw():void 
		{
			// init vars
			var step : Number;
			var halfStep : Number; 
			var start : Number; 
			var n : Number;
			var dx : Number; 
			var dy : Number;
			
			var centerPt:Point = (_center) ? new Point(): new Point(_radius, _radius);
			
			// calculate distance between points
			step = (Math.PI * 2) / points;
			halfStep = step / 2;
			
			// calculate starting angle in radians
			start = (90 / 180) * Math.PI;
			graphics.moveTo( centerPt.x + (Math.cos( start ) * _radius), centerPt.y - (Math.sin( start ) * _radius) );
			
			// draw lines
			for (n = 1; n <= _points; ++n) 
			{
				dx = centerPt.x + Math.cos( start + (step * n) - halfStep ) * _innerRadius;
				dy = centerPt.y - Math.sin( start + (step * n) - halfStep ) * _innerRadius;
				graphics.lineTo( dx, dy );
				
				dx = centerPt.x + Math.cos( start + (step * n) ) * _radius;
				dy = centerPt.y - Math.sin( start + (step * n) ) * _radius;
				graphics.lineTo( dx, dy );
			}
			
			super.draw();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get center():Boolean { return _center; }
		public function set center(value:Boolean):void
		{
			_center = value;
			invalidateProperties();
		}
		
		public function get points():int { return _points; }
		public function set points(value:int):void
		{
			_points = value;
			invalidateProperties();
		}
		
		public function get innerRadius():int { return _innerRadius; }
		public function set innerRadius(value:int):void
		{
			_innerRadius = value;
			invalidateProperties();
		}
		
		public function get radius():int { return _radius; }
		public function set radius(value:int):void
		{
			_radius = value;
			invalidateProperties();
		}
	}

}