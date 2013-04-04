package com.savage.game
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Transform;

	public class Agent2D extends AgentBase
	{
		private var _rotation:Number = 0;
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		
		/**
		 * Constructor
		 */
		public function Agent2D(transform:Transform)
		{
			super(transform);
		}
		
		override public function render():void
		{
			super.render();
			
			var m:Matrix = new Matrix();
			m.translate(x, y);
			m.rotate(_rotation);
			m.scale(_scaleX, _scaleY);
			
			//move target to this location
			transform.matrix = m;
		}

		/**************************************
		 * Accessors
		 **************************************/
		
		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		public function get scaleX():Number
		{
			return _scaleX;
		}

		public function set scaleX(value:Number):void
		{
			_scaleX = value;
		}

		public function get scaleY():Number
		{
			return _scaleY;
		}

		public function set scaleY(value:Number):void
		{
			_scaleY = value;
		}
		
		/**************************************
		 * Static
		 **************************************/
		
		public static function getTargetSize(target:DisplayObject):Rectangle
		{
			return new Rectangle(0,0,target.width, target.height);
		}
		
		public static function getSize(w:Number, h:Number):Rectangle
		{
			return new Rectangle(0,0,w,h);
		}
	}
}