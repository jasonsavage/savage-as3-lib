package com.savage.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapUtil
	{
		/**
		 * Creates a multi-dementional array of bitmap tiles out of the supplied bitmap.
		 * @param target
		 * @param rows
		 * @param columns
		 * @return 
		 */		
		public static function slice(target:Bitmap, rows:int=4, columns:int=8):Array
		{
			//Calculate block size
			var tileWidth:Number = target.width / columns;
			var tileHeight:Number = target.height / rows;
			
			var sourceBmd:BitmapData = new BitmapData(tileWidth * columns, tileHeight * columns, true, 0);
			sourceBmd.draw( target );
			
			var tileGrid:Array = new Array();
			
			for(var i:int = 0; i < rows; i++)
			{
				tileGrid[i] = new Array();
				
				for(var j:int = 0; j < columns; j++)
				{
					var rect:Rectangle = new Rectangle(j * tileWidth, i * tileHeight, tileWidth, tileHeight);
					var bmd:BitmapData = new BitmapData(tileWidth, tileHeight, true, 0);
					bmd.copyPixels(sourceBmd, rect, new Point() );
					
					var tile:Bitmap = new Bitmap(bmd);
					
					tileGrid[i][j] = tile;
				}
			}
			
			return tileGrid;
		}
		
		public static function draw(target:DisplayObjectContainer):Bitmap
		{
			var bmd:BitmapData = new BitmapData(target.width / target.scaleX, target.height / target.scaleY, true, 0);
			for(var i:int = 0; i < target.numChildren; i++)
			{
				var child:DisplayObject = target.getChildAt(i);
				bmd.draw(child, child.transform.matrix);
			}
			
			return new Bitmap(bmd, "auto", true);
		}
	}
}