package com.savage.graphics 
{
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;

	/**
	 * ...
	 * @author Jason Savage
	 */
	public class CircleShape extends SolidShape
	{
		private var _center:Boolean;
		
		/**
		 * Constructor
		 */
		public function CircleShape(width:Number = 10, height:Number = 10, color:uint = 0, center:Boolean=false) 
		{
			super(width, height, new SolidFillStyle(color));
			_center = center;
		}
		
		override public function clone():DrawnShape 
		{
			return new CircleShape(drawnWidth, drawnHeight, SolidFillStyle(fillStyle).color, _center);
		}
		
		override protected function draw():void 
		{
			if (_center)
				graphics.drawEllipse(-(drawnWidth * 0.5), -(drawnHeight * 0.5), drawnWidth, drawnHeight);
			else
				graphics.drawEllipse(0, 0, drawnWidth, drawnHeight);
				
			super.draw();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get center():Boolean { return _center; }
		public function set center(value:Boolean):void
		{
			_center = value;
			invalidateProperties();
		}
	}

}