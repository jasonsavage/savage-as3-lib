package com.savage.graphics.complex 
{
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;

	/**
	 * ...
	 * @author Jason Savage
	 */
	public class LineGroup extends SolidShape
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private var _orientation:String;
		private var _amount:int;
		private var _thickness:int;
		
		/**
		 * Constructor
		 */
		public function LineGroup(orientation:String="horizontal", width:Number=10, height:Number=10, amount:int=5, thickness:int=1, color:uint = 0) 
		{
			_orientation 	= orientation;
			_amount 		= amount;
			_thickness 		= thickness;
			
			super(width, height, new SolidFillStyle(color));
		}
		
		override protected function draw():void 
		{
			var gap:Number = calculateGap();
			
			for (var i:int = 0; i < _amount; i++)
			{
				if(_orientation == HORIZONTAL)
					graphics.drawRect((_thickness + gap) * i, 0, _thickness, drawnHeight);
					
				if (_orientation == VERTICAL)
					graphics.drawRect(0, (_thickness + gap) * i, drawnWidth, _thickness);
			}
			
			super.draw();
		}
		
		/**
		 * Calculates the gap between each line.
		 * (total width) - (the width of each line) / (amount of lines to draw)
		 * @return
		 */
		private function calculateGap():Number
		{
			if(_orientation == HORIZONTAL)
				return Math.floor((drawnWidth - (amount * thickness)) / amount) ;
					
			if (_orientation == VERTICAL)
				return Math.floor((drawnHeight - (amount * thickness)) / amount);
				
			return 0;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get amount():int { return _amount; }
		public function set amount(value:int):void
		{
			_amount = value;
			invalidateProperties();
		}
		
		public function get thickness():int { return _thickness; }
		public function set thickness(value:int):void
		{
			_thickness = value;
			invalidateProperties();
		}
		
		public function get orientation():String { return _orientation; }
		public function set orientation(value:String):void
		{
			_orientation = value;
			invalidateProperties();
		}
	}

}