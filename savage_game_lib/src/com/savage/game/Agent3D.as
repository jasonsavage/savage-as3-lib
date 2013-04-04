package com.savage.game
{
	import flash.geom.Matrix3D;
	import flash.geom.Transform;
	import flash.geom.Vector3D;

	public class Agent3D extends AgentBase
	{
		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var _rotationZ:Number = 0;
		
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		private var _scaleZ:Number = 1;
		
		private var _z:Number = 0;
		
		/**
		 * Constructor
		 */
		public function Agent3D(transform:Transform)
		{
			super(transform);
		}
		
		override public function render():void
		{
			super.render();
			
			var m:Matrix3D = new Matrix3D();
			m.appendTranslation(x, y, _z);
			m.appendRotation(_rotationX, Vector3D.X_AXIS);
			m.appendRotation(_rotationY, Vector3D.Y_AXIS);
			m.appendRotation(_rotationZ, Vector3D.Z_AXIS);
			m.appendScale(_scaleX, _scaleY, _scaleZ);
			
			//move target to this location
			transform.matrix3D = m;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get rotationX():Number
		{
			return _rotationX;
		}

		public function set rotationX(value:Number):void
		{
			_rotationX = value;
		}

		public function get rotationY():Number
		{
			return _rotationY;
		}

		public function set rotationY(value:Number):void
		{
			_rotationY = value;
		}

		public function get rotationZ():Number
		{
			return _rotationZ;
		}

		public function set rotationZ(value:Number):void
		{
			_rotationZ = value;
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

		public function get scaleZ():Number
		{
			return _scaleZ;
		}

		public function set scaleZ(value:Number):void
		{
			_scaleZ = value;
		}

		public function get z():Number
		{
			return _z;
		}

		public function set z(value:Number):void
		{
			_z = value;
		}
	}
}