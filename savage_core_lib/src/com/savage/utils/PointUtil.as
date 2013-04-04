package com.savage.utils 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PointUtil 
	{
		
		public static function point(obj:Object):Point
		{
			if (obj.x && obj.y)	
				return new Point(obj.x, obj.y);
			
			return new Point();
		}
		
		/**
		 * Returns the angle between 2 points in degrees.
		 * @param	ptA
		 * @param	ptB
		 * @return
		 */
		public static function angle(ptA:Point, ptB:Point):Number
		{
			var radians:Number = Math.atan2((ptB.y - ptA.y), (ptB.x - ptA.x));
			return radians * 180/Math.PI;
		}
		
		/**
		 * Returns the distance (hypotenuse) between 2 points.
		 * @param	ptA
		 * @param	ptB
		 * @return
		 */
		public static function distance(ptA:Point, ptB:Point):Number
		{
			var pt:Point = distancePoint(ptA, ptB);
			return Math.sqrt((pt.x * pt.x) + (pt.y * pt.y));
		}
		
		/**
		 * Returns the distance x and distance y between 2 points.
		 * @param	ptA
		 * @param	ptB
		 * @return
		 */
		public static function distancePoint(ptA:Point, ptB:Point):Point
		{
			var pt:Point = new Point();
			pt.x = ptB.x - ptA.x;
			pt.y = ptB.y - ptA.y;
			return pt;
		}
		
		/**
		 * Returns the slope of the line between the 2 specified points.
		 * The slope of a line in the plane containing the x and y axes is generally represented by the letter m, 
		 * and is defined as the change in the y coordinate divided by the corresponding change in the x coordinate, 
		 * between two distinct points on the line.
		 * @param	ptA
		 * @param	ptB
		 * @return
		 */
		public static function getSlope(ptA:Point, ptB:Point):Number
		{
			var pt:Point = distancePoint(ptA, ptB);
			return pt.y / pt.x;
		}
		
		/**
		 * Calculates a Quadratic Bezier curve path based on the supplied 3 points.
		 * B(t) = (1-t)^2 * P0 + 2 * (1-t) * t * P1 + t^2 * P2
		 * @param	steps - amount of Points to return in the Vector array
		 * @param	pt0 - start Point
		 * @param	pt1 - curve towards this point
		 * @param	pt2 - end Point
		 * @return
		 */
		public static function getQuadraticBezierCurve(steps:int, pt0:Point, pt1:Point, pt2:Point):Array
		{
			var retVal:Array = new Array();
			for (var i:int = 0; i < steps; i++)
			{
				var t:Number = i / steps;
				var u:Number = 1 - t;
				var pt:Point = new Point();

				pt.x = (u * u * pt0.x) + (2 * u * t * pt1.x) + (t * t * pt2.x);
				pt.y = (u * u * pt0.y) + (2 * u * t * pt1.y) + (t * t * pt2.y);
				
				retVal.push(pt);
			}
			return retVal;
		}
		
		/**  
		 * Calculates a Cubic Bezier curve path based on the supplied 4 points.
		 * B(t) = (1-t)^3 * P0 + 3 * (1-t)^2 * t * P1 + 3 * (1-t) * t^2 * P2 + t^3 * P3
		 * @param	steps - amount of Points to return in the Vector array
		 * @param	pt0 - start Point
		 * @param	pt1 - curve towards this point
		 * @param	pt2 - curve towards this point
		 * @param	pt3 - end Point
		 * @return
		 */
		public static function getCubicBezierCurve(steps:int, pt0:Point, pt1:Point, pt2:Point, pt3:Point):Array
		{
			var retVal:Array = new Array();
			for (var i:int = 0; i < steps; i++)
			{
				var t:Number = i / steps;
				var u:Number = 1 - t;
				var pt:Point = new Point();
				
				pt.x = (u * u * u * pt0.x) + (3 * u * u * t * pt1.x) + (3 * u * t * t * pt2.x) + (t * t * t * pt3.x);
				pt.y = (u * u * u * pt0.y) + (3 * u * u * t * pt1.y) + (3 * u * t * t * pt2.y) + (t * t * t * pt3.y);
				
				retVal.push(pt);
			}
			return retVal;
		}
		
		/**
		 * Returns the point that is at the angle and radius from the supplied point.
		 * To cause an orbit effect just increment the angle call this method in a loop.
		 * @param	ptA
		 * @param	angle
		 * @param	radius
		 * @param	multiplyX
		 * @param	multiplyY
		 * @return
		 */
		public static function orbit(ptA:Point, angle:Number, radius:Number, multiplyX:Number=1, multiplyY:Number=1):Point
		{
			var ptB:Point = new Point();
			var rad:Number = angle * (Math.PI / 180);
			ptB.x = ptA.x + radius * Math.cos(rad) * multiplyX;
			ptB.y = ptA.y + radius * Math.sin(rad) * multiplyY;
			
			return ptB;
		}
		
		/**
		 * Gets the next point as the current point moves towards the target point at a rate of constant
		 * @param	current
		 * @param	target
		 * @param	constant
		 */
		public static function chasePoint(current:Point, target:Point, constant:Number):Point
		{
			var ptB:Point = new Point(current.x, current.y);
			ptB.x += (target.x - current.x) / constant;
			ptB.y += (target.y - current.y) / constant;
			return ptB;
		}
		
		/**
		 * Gets a point that is at the angle and radius from the supplied point.
		 * @param	ptA - starting point
		 * @param	angle - 
		 * @param	distance
		 * @param	angleIsRadians - if the supplied angle is in radians
		 * @return
		 */
		public static function getPointAtAngle(ptA:Point, angle:Number, radius:Number, angleIsRadians:Boolean=false):Point
		{
			var radians:Number = (angleIsRadians) ? angle : angle * Math.PI/180;
			
			var ptB:Point = new Point();
			ptB.x = ptA.x + radius * Math.cos(radians);
			ptB.y = ptA.y + radius * Math.sin(radians);
			return ptB;
		}

		
	}

}