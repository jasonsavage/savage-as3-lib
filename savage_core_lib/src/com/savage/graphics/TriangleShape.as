package com.savage.graphics 
{
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class TriangleShape extends SolidShape
	{
		private var _center:Boolean;
		
		/**
		 * Constructor
		 */
		public function TriangleShape(width:Number = 10, height:Number = 10, color:uint = 0, center:Boolean=false)  
		{
			super(width, height, new SolidFillStyle(color));
			_center = center;
		}
		
		override public function clone():DrawnShape 
		{ 
			return new TriangleShape(drawnWidth, drawnHeight, SolidFillStyle(fillStyle).color, _center);
		}
		
		override protected function draw():void 
		{
			if (_center)
			{
				graphics.moveTo( -(drawnWidth / 2), -(drawnHeight / 2) );
				graphics.lineTo( (drawnWidth / 2) , 0 );
				graphics.lineTo( -(drawnWidth / 2), (drawnHeight / 2) );
				graphics.lineTo( -(drawnWidth / 2), -(drawnHeight / 2) );
			}
			else
			{
				graphics.moveTo( 0, 0 );
				graphics.lineTo( drawnWidth, (drawnHeight / 2) );
				graphics.lineTo( 0, drawnHeight );
				graphics.lineTo( 0, 0 );
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
	}

}