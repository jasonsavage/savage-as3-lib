package com.savage.graphics.complex 
{
	import com.savage.graphics.core.DrawnShape;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ContractIcon extends DrawnShape
	{
		private var _thickness:int;
		private var _color:uint;
		
		/**
		 * Constructor
		 */
		public function ContractIcon(width:Number = 10, height:Number = 10, color:uint = 0, thickness:int=1) 
		{
			super(width, height);
			
			_color = color;
			_thickness = thickness;
		}
		
		override protected function beginDraw():void 
		{
			super.beginDraw();
			
			graphics.clear();
			graphics.lineStyle(_thickness, _color);
		}
		
		override protected function draw():void 
		{
			var w3:Number = drawnWidth / 3;
			var h3:Number = drawnHeight / 3;
			
			//top left
			graphics.moveTo(0, h3);
			graphics.lineTo(w3, h3);
			graphics.lineTo(w3, 0);
			
			graphics.moveTo(0, 0);
			graphics.lineTo(w3, h3);
			
			//top right
			graphics.moveTo(drawnWidth, h3);
			graphics.lineTo(drawnWidth-w3, h3);
			graphics.lineTo(drawnWidth-w3, 0);
			
			graphics.moveTo(drawnWidth, 0);
			graphics.lineTo(drawnWidth-w3, h3);
			
			//bot left
			graphics.moveTo(0, drawnHeight-h3);
			graphics.lineTo(w3, drawnHeight-h3);
			graphics.lineTo(w3, drawnHeight);
			
			graphics.moveTo(0, drawnHeight);
			graphics.lineTo(w3, drawnHeight-h3);
			
			//bot right
			graphics.moveTo(drawnWidth, drawnHeight-h3);
			graphics.lineTo(drawnWidth-w3, drawnHeight-h3);
			graphics.lineTo(drawnWidth - w3, drawnHeight);
			
			graphics.moveTo(drawnWidth, drawnHeight);
			graphics.lineTo(drawnWidth - w3, drawnHeight - h3);
			
			super.draw();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get thickness():int { return _thickness; }
		public function set thickness(value:int):void
		{
			_thickness = value;
			invalidateProperties();
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			_color = value;
			invalidateProperties();
		}
		
	}

}