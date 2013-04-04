package com.savage.graphics.styles
{
	import com.savage.utils.MathUtil;
	
	import flash.display.Graphics;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author Jason Savage
	 */
	public class GradientFillStyle extends FillStyle
	{
		private var _gradientType:String;
		private var _spreadMethod:String;
		private var _colors:Array;
		private var _alphas:Array;
		private var _ratios:Array;
		private var _gradientMatrix:Matrix;

		/**
		 * Constructor
		 * @param	gradientType
		 * @param	colors
		 * @param	alphas
		 * @param	ratios
		 * @param	gradientMatrix
		 * @param	spreadMethod
		 */
		public function GradientFillStyle(gradientType:String="linear", colors:Array=null, alphas:Array=null, ratios:Array=null, gradientMatrix:Matrix=null, spreadMethod:String="pad") 
		{
			_gradientType = gradientType;
			_colors = colors ? colors : [0xFFFFFF, 0x000000];
			_alphas = alphas ? alphas : [1,1];
			_ratios = ratios ? ratios : [0, 255];
			_gradientMatrix = gradientMatrix ? gradientMatrix : new Matrix();
			_spreadMethod = spreadMethod;
		}
		
		public function createGradientBox(width:Number, height:Number, angleDegrees:Number):void
		{
			_gradientMatrix.createGradientBox(width, height, MathUtil.radians(angleDegrees));
		}
		
		override public function applyFill(graphics:Graphics):void
		{
			graphics.beginGradientFill(_gradientType, _colors, _alphas, _ratios, _gradientMatrix, _spreadMethod); 
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get gradientType():String { return _gradientType; }
		public function set gradientType(value:String):void
		{
			_gradientType = value;
		}

		public function get spreadMethod():String { return _spreadMethod; }
		public function set spreadMethod(value:String):void
		{
			_spreadMethod = value;
		}
		 
		public function get colors():Array { return _colors; }
		public function set colors(value:Array):void
		{
			_colors = value;
		}

		public function get alphas():Array { return _alphas; }
		public function set alphas(value:Array):void
		{
			_alphas = value;
		}
		
		public function get ratios():Array { return _ratios; }
		public function set ratios(value:Array):void
		{
			_ratios = value;
		}
		
		public function get gradientMatrix():Matrix { return _gradientMatrix; }
		public function set gradientMatrix(value:Matrix):void
		{
			_gradientMatrix = value;
		}
		
	}

}