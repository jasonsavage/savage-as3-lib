package com.savage.graphics 
{
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class RectangleShape extends SolidShape
	{
		private var _center:Boolean;
		private var _cornerRadius:int;
		
		/**
		 * Constructor
		 */
		public function RectangleShape(width:Number = 10, height:Number = 10, color:uint = 0, cornerRadius:int=0, center:Boolean=false) 
		{
			super(width, height, new SolidFillStyle(color));
			_cornerRadius = cornerRadius;
			_center = center;
		}
		
		override public function clone():DrawnShape 
		{
			return new RectangleShape(drawnWidth, drawnHeight, SolidFillStyle(fillStyle).color, cornerRadius, center);
		}
		
		override protected function draw():void 
		{
			if (center)
				graphics.drawRoundRect(-(drawnWidth * 0.5), -(drawnHeight * 0.5), drawnWidth, drawnHeight, cornerRadius);
			else
				graphics.drawRoundRect(0, 0, drawnWidth, drawnHeight, cornerRadius);
				
			super.draw();
		}
		
		/**************************************
		 * Accessors  
		 **************************************/
		
		public function get cornerRadius():int { return _cornerRadius; }
		public function set cornerRadius(value:int):void
		{
			_cornerRadius = value;
			invalidateProperties();
		}
		
		public function get center():Boolean { return _center; }
		public function set center(value:Boolean):void
		{
			_center = value;
			invalidateProperties();
		}
	}

}