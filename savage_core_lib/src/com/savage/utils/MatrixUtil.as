package com.savage.utils
{
	import flash.geom.Matrix;
	
	
	/**
	 * TODO: Document Class
	 * @author Jason Savage
	 */
	public class MatrixUtil
	{
		/**
		 * TODO: Document Method
		 * @param	m
		 * @param	x
		 * @param	y
		 * @return
		 */
		public static function translate(m:Matrix=null, x:Number=0, y:Number=0):Matrix
		{
			if(m == null) m = new Matrix();
			if(x != 0) m.tx = x;
			if(y != 0) m.ty = y;
			return m;
		}
		
		/**
		 * TODO: Document Method
		 * @param	m
		 * @param	scaleX
		 * @param	scaleY
		 * @return
		 */
		public static function scale(m:Matrix=null, scaleX:Number=0, scaleY:Number=0):Matrix
		{
			if(m == null) m = new Matrix();
			if(scaleX != 0) m.a = scaleX;
			if(scaleY != 0) m.d = scaleY;
			return m;
		}
		
		/**
		 * TODO: Document Method
		 * @param	m
		 * @param	angleRadians
		 * @return
		 */
		public static function rotate(m:Matrix=null, angleRadians:Number=0):Matrix
		{
			if(m == null) m = new Matrix();
			m.a = Math.cos(angleRadians);
			m.b = Math.sin(angleRadians);
			m.c = -Math.sin(angleRadians);
			m.d = Math.cos(angleRadians);
			return m;
		}
		
		/**
		 * TODO: Document Method
		 * @param	m
		 * @param	x
		 * @param	y
		 * @return
		 */
		public static function skew(m:Matrix=null, x:Number=0, y:Number=0):Matrix
		{
			if(m == null) m = new Matrix();
			if(y != 0) m.b = Math.tan(y);
			if(x != 0) m.c = Math.tan(x);
			return m;
		}

	}
}