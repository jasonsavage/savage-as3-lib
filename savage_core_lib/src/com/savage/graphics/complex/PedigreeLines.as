package com.savage.graphics.complex 
{
	import com.savage.graphics.core.DrawnShape;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PedigreeLines extends DrawnShape 
	{
		public static const RIGHT:String = "right";
		public static const LEFT:String = "left";
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		
		private var _direction:String;
		private var _offset:int;
		private var _color:uint = 0;
		private var _thickness:int = 1;
		
		private var _parentA:DisplayObject;
		private var _parentB:DisplayObject;
		private var _children:Array;
		private var _sharedGraphics:Graphics;
		
		/**
		 * Constructor
		 */
		public function PedigreeLines(direction:String="left", offset:int=20, color:uint=0, thickness:int=1) 
		{
			super(10, 10);
			
			_direction = direction;
			_offset = offset;
			_color = color;
			_thickness = thickness;
		}
		
		override protected function beginDraw():void 
		{
			super.beginDraw();
			
			var canvas:Graphics = getCanvas();
			
			if (canvas == graphics)
				canvas.clear();
				
			canvas.lineStyle(_thickness, _color);
		}
		
		override protected function draw():void 
		{
			if (!_parentA || !_parentB || !_children) return;
			if (_children.length == 0) return;
			
			var canvas:Graphics = getCanvas();
			
			switch(_direction)
			{
				case LEFT :
					drawLeftPedigree(canvas);
				break;
				
				case RIGHT :
					drawRightPedigree(canvas);
				break;
				
				case BOTTOM :
					drawBottomPedigree(canvas);
				break;
				
				case TOP :
					drawTopPedigree(canvas);
				break;
			}
			
			drawnWidth = width;
			drawnHeight = height;
			
			super.draw();
		}
		
		private function drawLeftPedigree(canvas:Graphics):void
		{
			var offsetX:Number = _parentA.x;
			var parentAY:Number = _parentA.y + _parentA.height * 0.5;
			var parentBY:Number = _parentB.y + _parentB.height * 0.5;
			
			if (_parentB.x < offsetX)
				offsetX = _parentB.x;
			
			offsetX -= _offset;
			
			canvas.moveTo( _parentA.x, parentAY );
			canvas.lineTo( offsetX, parentAY );
			canvas.lineTo( offsetX, parentBY );
			canvas.lineTo( _parentB.x, parentBY );
				
			var i:int = _children.length;
			while(i--)
			{
				var child:DisplayObject = _children[i] as DisplayObject;
				if (child)
				{
					var childY:Number = child.y + child.height * 0.5;
					
					canvas.moveTo( child.x + child.width, childY );
					canvas.lineTo( offsetX, childY );
					
					if (childY > parentBY)
						canvas.lineTo(offsetX, parentBY);
					
					if (childY < parentAY)
						canvas.lineTo(offsetX, parentAY);
				}
			}
		}
		
		private function drawTopPedigree(canvas:Graphics):void
		{
			var offsetY:Number = _parentA.y + _parentA.height;
			var parentAX:Number = _parentA.x + _parentA.width * 0.5;
			var parentBX:Number = _parentB.x + _parentB.width * 0.5;
			
			if (_parentB.y + _parentB.height > offsetY)
				offsetY = _parentB.y + _parentB.height;
			
			offsetY += _offset;
			
			canvas.moveTo(parentAX, _parentA.y + _parentA.height);
			canvas.lineTo(parentAX, offsetY);
			canvas.lineTo(parentBX, offsetY);
			canvas.lineTo(parentBX, _parentB.y + _parentB.height);
				
			var i:int = _children.length;
			while(i--)
			{
				var child:DisplayObject = _children[i] as DisplayObject;
				if (child)
				{
					var childX:Number = child.x + child.width * 0.5;
					
					canvas.moveTo(childX, child.y);
					canvas.lineTo(childX, offsetY);
					
					if (childX < parentAX)
						canvas.lineTo(parentAX, offsetY);
					
					if (childX > parentBX)
						canvas.lineTo(parentBX, offsetY);
				}
			}
		}
		
		private function drawBottomPedigree(canvas:Graphics):void
		{
			var offsetY:Number = _parentA.y;
			var parentAX:Number = _parentA.x + _parentA.width * 0.5;
			var parentBX:Number = _parentB.x + _parentB.width * 0.5;
			
			if (_parentB.y < offsetY)
				offsetY = _parentB.y;
			
			offsetY -= _offset;
			
			canvas.moveTo(parentAX, _parentA.y );
			canvas.lineTo(parentAX, offsetY);
			canvas.lineTo(parentBX, offsetY);
			canvas.lineTo(parentBX, _parentB.y);
				
			var i:int = _children.length;
			while(i--)
			{
				var child:DisplayObject = _children[i] as DisplayObject;
				if (child)
				{
					var childX:Number = child.x + child.width * 0.5;
					
					canvas.moveTo(childX, child.y + child.height);
					canvas.lineTo(childX, offsetY);
					
					if (childX < parentAX)
						canvas.lineTo(parentAX, offsetY);
					
					if (childX > parentBX)
						canvas.lineTo(parentBX, offsetY);
				}
			}
		}
		
		private function drawRightPedigree(canvas:Graphics):void
		{
			var offsetX:Number = _parentA.x + _parentA.width;
			var parentAY:Number = _parentA.y + _parentA.height * 0.5;
			var parentBY:Number = _parentB.y + _parentB.height * 0.5;
			
			if (_parentB.x + _parentB.width > offsetX)
				offsetX = _parentB.x + _parentB.width;
			
			offsetX += _offset;
			
			canvas.moveTo(_parentA.x + _parentA.width, parentAY);
			canvas.lineTo(offsetX, parentAY);
			canvas.lineTo(offsetX, parentBY);
			canvas.lineTo(_parentB.x + _parentB.width, parentBY);
				
			var i:int = _children.length;
			while(i--)
			{
				var child:DisplayObject = _children[i] as DisplayObject;
				if (child)
				{
					var childY:Number = child.y + child.height * 0.5;
					
					canvas.moveTo(child.x, childY);
					canvas.lineTo(offsetX, childY);
					
					if (childY > parentBY)
						canvas.lineTo(offsetX, parentBY);
					
					if (childY < parentAY)
						canvas.lineTo(offsetX, parentAY);
				}
			}
		}
		
		private function getCanvas():Graphics
		{
			return (_sharedGraphics) ? _sharedGraphics : graphics;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get sharedGraphics():Graphics { return _sharedGraphics; }
		public function set sharedGraphics(value:Graphics):void
		{
			_sharedGraphics = value;
			invalidateProperties();
		} 
		
		public function get offset():int { return _offset; }
		public function set offset(value:int):void
		{
			_offset = value;
			invalidateProperties();
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			_color = value;
			invalidateProperties();
		}
		
		public function get thickness():int { return _thickness; }
		public function set thickness(value:int):void
		{
			_thickness = value;
			invalidateProperties();
		}
		
		public function get parentA():DisplayObject { return _parentA; }
		public function set parentA(value:DisplayObject):void
		{
			_parentA = value;
			invalidateProperties();
		}
		
		public function get parentB():DisplayObject { return _parentB; }
		public function set parentB(value:DisplayObject):void
		{
			_parentB = value;
			invalidateProperties();
		}
		
		public function get children():Array { return _children; }
		public function set children(value:Array):void
		{
			_children = value;
			invalidateProperties();
		}
	}
}