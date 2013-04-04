package com.savage.utils
{
	import flash.geom.Point;
	
	/**
	 * The MathUtil class contains static methods for calculating values.
	 * @author Jason Savage
	 */
	public class MathUtil
	{
		/**
		 * Steps the specified value towards zero at a rate of increment.
		 */
		public static function stepToZero(value:Number, increment:Number):Number
		{
			if(value > 0)
				return value - increment;
			
			if(value < 0)
				return value + increment;
			
			return 0;
		}
		
		/**
		 * Returns the value if it is between the values of min and max, else if larger than max returns max and vice versa.
		 * @param	value
		 * @param	min
		 * @param	max
		 * @return
		 */
		public static function limit(value:Number, min:Number, max:Number):Number
		{
			return Math.max(Math.min(value, max), min);
		}
		
		/**
		 * Returns the value if it is between the values of min and max, else if larger than max returns min and vice versa.
		 * @param	value
		 * @param	min
		 * @param	max
		 * @return
		 */
		public static function limitWrap(value:Number, min:Number, max:Number):Number
		{
			if (value < min)
				return max;
				
			if (value > max)
				return min;
				
			return value;
		}
		
		/**
		 * Scroll Bar Equation
		 * @param	thumbPos
		 * @param	thumbMax
		 * @param	contentPos
		 * @param	contentMax
		 * @return
		 */
		public static function scroll(thumbPos:Number, thumbMax:Number, contentPos:Number, contentMax:Number):Number
		{
			contentMax = contentMax + contentPos;
			return Math.floor(((thumbPos / thumbMax) * contentMax) - contentPos);
		}
		
		/**
		 * Converts the specified angle from radians to degrees.
		 * @param	radians
		 * @return
		 */
		public static function degrees(radians:Number):Number
		{
			return radians * 180/Math.PI;
		}
		
		/**
		 * Converts the specified angle from degrees to radians.
		 * @param	degrees
		 * @return
		 */
		public static function radians(degrees:Number):Number
		{
			return degrees * Math.PI/180;
		}
		
		/**
		 * Converts the specified slope into degrees.
		 * @param	slope
		 * @return
		 */
		public static function slopeToDegrees(slope:Number):Number
		{
			return Math.atan(slope) * 180/Math.PI;
		}
		
		/**
		 * Gets the next number as the current number moves towards the target number at a rate of constant
		 * @param	current
		 * @param	target
		 * @param	constant
		 */
		public static function chase(current:Number, target:Number, constant:Number):Number
		{
			var change:Number = (target - current) / constant;
			return current + change;
		}
		
		/**
		 * Rounds a number to a specified decemal place.
		 * @param	value
		 * @param	places
		 * @return
		 */
		public static function round(value:Number, places:int):Number 
		{
			var exp:int = Math.pow(10, places); 
			return Math.round(value * exp) / exp;
		}
		
		/**
		 * Faster Math.abs() function for ints using bitwise operators
		 * @param	x
		 * @return
		 */
		public static function abs(x:int):int
		{
			return (x ^ (x >> 31)) - (x >> 31);
		}
		
		/**
		 * Fast check if an int is even using bitwise operators
		 * @param	x
		 * @return
		 */
		public static function even(x:int):Boolean
		{
			return (x & 1) == 0;
		}
		
		/**
		 * Flips the sign of a number using bitwise operators
		 * @param	x
		 * @return
		 */
		public static function swapSign(x:int):int
		{
			return (x ^ -1) + 1;
		}
		
		/**
		 * Fast Math.foor() function for ints using bitwise operators
		 * @param	x
		 * @return
		 */
		public static function floor(x:Number):int
		{
			return x >> 0;
		}
		
		/**
		 * Divides the number in have using bitwise operators
		 * @param	x
		 * @return
		 */
		public static function half(x:Number):int
		{
			return x >> 1;
		}
		
		/**
		 * Returs true or false if the value is close to the target number
		 * @param	x
		 * @return
		 */
		public static function inRange(value:Number, target:Number, range:Number = 1):Boolean
		{
			return (value < (target + range) &&  value > (target - range));
		}
		
		/**
		 * Gets a random integer between min and max. 
		 * This method will not return two of the same numbers in a row.
		 * @param	min
		 * @param	max
		 */
		private static var _randomRangeIntLast:Number = 999999999999999;
		public static function randomRangeInt( min:Number, max:Number):int
		{
			if(min == max)
				return min;
			
			do
			{
				var retVal:int = randomRange(min, max);
			}
			while(retVal == _randomRangeIntLast)
			
			_randomRangeIntLast = retVal;
			
			return retVal;
		}
		
		/**
		 * Gets a random number between the values of min and max.
		 * @param	min
		 * @param	max
		 * @return
		 */
		public static function randomRange(min:Number, max:Number):Number 
		{
			return (Math.random() * (max-min)) + min;
		}
		
		/**
		 * Gets a random number between 0 and max.
		 * @param	max
		 */
		public static function random(max:Number=1):Number 
		{
			return Math.random() * max;
		}
	}
}