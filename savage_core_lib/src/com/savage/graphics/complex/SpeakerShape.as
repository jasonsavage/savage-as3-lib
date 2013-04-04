package com.savage.graphics.complex 
{
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SpeakerShape extends SolidShape
	{
		/**
		 * Constructor
		 */
		public function SpeakerShape(width:Number = 10, height:Number = 10, color:uint = 0) 
		{
			super(width, height, new SolidFillStyle(color));
		}
		
		override protected function draw():void 
		{
			//example w = 5, h = 10
			var wh:Number = drawnWidth / 2; 	// 5/2  = 2.5
			var hh:Number = drawnHeight / 2;	// 10/2 = 5
			var hf:Number = drawnHeight / 4;	// 10/4 = 2.5
			var hs:Number = drawnHeight / 6;	// 10/6 = 1.6
			var wt:Number = drawnWidth / 10; 	// 5/10 = 0.5
			
			var pt:Point = new Point(wh, hh);
			
			//rectangle
			graphics.moveTo( pt.x -wh, pt.y - hf );
			graphics.lineTo( pt.x - wt, pt.y - hf );
			graphics.lineTo( pt.x - wt, pt.y + hf );
			graphics.lineTo( pt.x - wh, pt.y + hf );
			graphics.lineTo( pt.x - wh, pt.y - hf );
			
			//trapazoid
			graphics.moveTo( pt.x + wt, pt.y + ( -hh + hs ) );
			graphics.lineTo( pt.x + wh, pt.y - hh );
			graphics.lineTo( pt.x + wh, pt.y + hh );
			graphics.lineTo( pt.x + wt, pt.y + ( hh - hs ) );
			
			super.draw();
		}
	}

}