package com.savage.graphics.styles
{
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class LineStyle
	{
		private var _thickness:int;
		private var _color:uint;
		private var _alpha:Number;
		private var _pixelHinting:Boolean;
		private var _scaleMode:String;
		private var _caps:String;
		private var _joints:String;
		private var _miterLimit:Number;
		
		/**
		 * Constructor
		 * @param	color
		 * @param	alpha
		 * @param	pixelHinting
		 * @param	scaleMode
		 * @param	caps
		 * @param	joints
		 * @param	miterLimit
		 */
		public function LineStyle(thickness:int=0, color:uint=0, alpha:Number=1, pixelHinting:Boolean=false, scaleMode:String="normal", caps:String="", joints:String="", miterLimit:Number=3) 
		{
			_thickness = thickness;
			_color = color;
			_alpha = alpha;
			_pixelHinting = pixelHinting;
			_scaleMode = scaleMode;
			_caps = caps;
			_joints = joints;
			_miterLimit = miterLimit;
		}
		
		public function applyLine( graphics:Graphics ):void
		{
			graphics.lineStyle(_thickness, _color, _alpha, _pixelHinting, _scaleMode, _caps, _joints, _miterLimit);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get thickness():int { return _thickness; }
		public function set thickness(value:int):void
		{
			_thickness = value;
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		public function get alpha():Number { return _alpha; }
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}

		public function get pixelHinting():Boolean { return _pixelHinting; }
		public function set pixelHinting(value:Boolean):void
		{
			_pixelHinting = value;
		}
		
		public function get scaleMode():String { return _scaleMode; }
		public function set scaleMode(value:String):void
		{
			_scaleMode = value;
		}
		
		public function get caps():String { return _caps; }
		public function set caps(value:String):void
		{
			_caps = value;
		}
		
		public function get joints():String { return _joints; }
		public function set joints(value:String):void
		{
			_joints = value;
		}
		
		public function get miterLimit():Number { return _miterLimit; }
		public function set miterLimit(value:Number):void
		{
			_miterLimit = value;
		}
		
	}

}