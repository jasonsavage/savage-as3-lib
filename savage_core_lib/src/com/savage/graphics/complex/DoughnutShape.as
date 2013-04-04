package com.savage.graphics.complex 
{
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class DoughnutShape extends SolidShape 
	{
		private var _outterRadius:Number;
		private var _innerRadius:Number;
		
		/**
		 * Constructor
		 * @param	outterRadius
		 * @param	innerRadius
		 * @param	color
		 */
		public function DoughnutShape(outterRadius:Number, innerRadius:Number, color:uint = 0) 
		{
			super(_outterRadius, _outterRadius, new SolidFillStyle(color));
			
			_outterRadius = outterRadius;
			_innerRadius = innerRadius;
		}
		
		override protected function draw():void 
		{
			var a:Number = 0.268;  // tan(15)
			var r1:Number = _outterRadius;
			var r2:Number = _innerRadius;
			var endx:Number;
			var endy:Number;
			var ax:Number;
			var ay:Number;
			var i:int;
			var toRadians:Number = Math.PI / 180;
			
			graphics.moveTo(0, 0);
			graphics.lineTo(r1, 0);
			
			// draw the 30-degree segments
			for (i = 0; i < 12; i++) 
			{
				endx = r1 * Math.cos((i + 1) * 30 * toRadians);
				endy = r1 * Math.sin((i + 1) * 30 * toRadians);
				ax = endx + r1 * a * Math.cos(((i + 1) * 30 - 90) * toRadians);
				ay = endy + r1 * a * Math.sin(((i + 1) * 30 - 90) * toRadians);
				graphics.curveTo(ax, ay, endx, endy);	
			}
			
			// cut out middle (go in reverse)
			graphics.moveTo(0, 0);
			graphics.lineTo(r2, 0);
			
			for (i = 12; i > 0; i--) 
			{
				endx = r2 * Math.cos((i - 1) * 30 * toRadians);
				endy = r2 * Math.sin((i - 1) * 30 * toRadians);
				ax = endx + r2 * (0 - a) * Math.cos(((i - 1) * 30 - 90) * toRadians);
				ay = endy + r2 * (0 - a) * Math.sin(((i - 1) * 30 - 90) * toRadians);
				graphics.curveTo(ax, ay, endx, endy);     
			}
			
			super.draw();
		}
	}

}