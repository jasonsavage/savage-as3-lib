package com.savage.graphics.complex 
{
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SpeakerVolumeLines extends SolidShape
	{
		private var _lineCount:int;
		private var _lineWidth:Number;
		
		/**
		 * Constructor
		 */
		public function SpeakerVolumeLines(lineCount:Number=10, lineWidth:Number=1, color:uint = 0) 
		{
			var w:Number = (lineCount + 1) * (lineWidth * 2);
			super(w, lineCount, new SolidFillStyle(color));
			
			_lineCount = lineCount;
			_lineWidth = lineWidth;
		}
		
		override protected function draw():void 
		{
			var pt:Point = new Point(0, lineCount * 0.5);
			for (var i:int = 1; i <= _lineCount; i++)
			{
				graphics.drawRect(pt.x + (i*(lineWidth*2)), pt.y + ((_lineCount-i)/2), lineWidth, i);
			}
			
			drawnHeight = height;
			drawnWidth = width;
			
			super.draw();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get lineCount():int { return _lineCount; }
		public function set lineCount(value:int):void
		{
			_lineCount = value;
			invalidateProperties();
		}
		
		public function get lineWidth():Number { return _lineWidth; }
		public function set lineWidth(value:Number):void
		{
			_lineWidth = value;
			invalidateProperties();
		}
	}

}