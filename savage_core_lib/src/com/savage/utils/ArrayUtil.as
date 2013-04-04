package com.savage.utils 
{
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ArrayUtil
	{
		
		public static function shuffle(value:Array):Array
		{
			for (var i:int = 0; i < value.length; i++) 
			{
				var pos:int = Math.random() * value.length;
				var temp:Object = value[i];
				value[i] = value[pos];
				value[pos] = temp;
			}
			return value;
		}
		
		public static function inArray(array:Array, value:Object):Boolean
		{
			return (array.indexOf(value) != -1);
		}
		
		/**
		 * Iterates and array and calls the callback method on each item in the array.
		 * This is just a simpler version of Array.foreach()
		 * @param	array
		 * @param	callback
		 * @return
		 */
		public static function foreach(array:Array, callback:Function):void
		{
			for (var i:int = 0; i < array.length; i++)
			{
				array[i] = callback(array[i]);
			}
		}
	}

}