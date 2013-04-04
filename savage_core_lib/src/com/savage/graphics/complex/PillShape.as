package com.savage.graphics.complex 
{
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PillShape extends SolidShape
	{
		public static const CURVE_LEFT:String = "left";
		public static const CURVE_RIGHT:String = "right";
		public static const CURVE_BOTH:String = "both";
		
		private var _curveSide:String;
		private var _center:Boolean;

		
		/**
		 * Constructor
		 */
		public function PillShape(width:Number = 100, height:Number = 50, color:uint = 0, curveSide:String="both", center:Boolean=false) 
		{
			super(width, height, new SolidFillStyle(color));
			
			_curveSide = curveSide;
			_center = center;
		}
		
		override protected function draw():void 
		{
			var size:Number = drawnHeight / 2;
			
			switch (_curveSide)
			{
				case CURVE_BOTH :
				
					graphics.moveTo(0, size);
					graphics.curveTo(0, 0, size, 0);
					graphics.lineTo(drawnWidth-size, 0);
					graphics.curveTo(drawnWidth, 0, drawnWidth, size);
					graphics.curveTo(drawnWidth, drawnHeight, drawnWidth - size, drawnHeight);
					graphics.lineTo(size, drawnHeight);
					graphics.curveTo(0, drawnHeight, 0, size);
					
				break;
				
				case CURVE_LEFT :
					
					graphics.moveTo(0, size);
					graphics.curveTo(0, 0, size, 0);
					graphics.lineTo(drawnWidth, 0);
					graphics.lineTo(drawnWidth, drawnHeight);
					graphics.lineTo(size, drawnHeight);
					graphics.curveTo(0, drawnHeight, 0, size);
				
				break;
				
				case CURVE_RIGHT :
					
					graphics.moveTo(0, 0);
					graphics.lineTo(drawnWidth-size, 0);
					graphics.curveTo(drawnWidth, 0, drawnWidth, size);
					graphics.curveTo(drawnWidth, drawnHeight, drawnWidth - size, drawnHeight);
					graphics.lineTo(0, drawnHeight);
					graphics.lineTo(0, 0);
					
				break;
			}
			
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
		public function get curveSide():String { return _curveSide; }
		public function set curveSide(value:String):void
		{
			_curveSide = value;
			invalidateProperties();
		}
	}

}