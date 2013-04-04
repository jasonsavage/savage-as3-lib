package com.savage.game.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SpriteSheet extends Bitmap
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		public static const TILE:String = "tile";
		
		private var _cellWidth:int;
		private var _cellHeight:int;
		private var _orientation:String;
		private var _bitmapData:BitmapData;
		private var _cells:Vector.<Rectangle>;
		
		/**
		 * Constructor
		 * @param	width
		 * @param	height
		 * @param	transparent
		 * @param	fillColor
		 */
		public function SpriteSheet(bitmapData:BitmapData, cellWidth:int, cellHeight:int, orientation:String="horizontal") 
		{
			super(null, "auto", true);
			
			_bitmapData = bitmapData;
			_cellWidth = cellWidth;
			_cellHeight = cellHeight;
			_orientation = orientation;
			
			initalize();
		}
		
		public function setView(index:int):void
		{
			var bmd:BitmapData = new BitmapData(_cellWidth, _cellHeight, true, 0);
			bmd.copyPixels( _bitmapData, _cells[index], new Point() );
			
			bitmapData = bmd;
			smoothing = true;
		}
		
		private function initalize():void
		{
			//build an array of rectangles for use as cells for this bitmapData
			_cells = new Vector.<Rectangle>();
			
			switch(_orientation)
			{
				case HORIZONTAL :
					createHorzGrid();
				break;
				
				case VERTICAL :
					createVertGrid();
				break;
				
				case TILE :
					createTileGrid();
				break;
			}
			
			setView(0);
		}
		
		private function createHorzGrid():void
		{
			var len:Number = _bitmapData.width / _cellWidth;
			for (var i:int; i < len; i++)
			{
				var rect:Rectangle = new Rectangle((i * _cellWidth), 0, _cellWidth, _cellHeight);
				_cells.push(rect);
			}
		}
		
		private function createVertGrid():void
		{
			var len:Number = _bitmapData.height / _cellHeight;
			for (var i:int; i < len; i++)
			{
				var rect:Rectangle = new Rectangle(0, (i * _cellHeight), _cellWidth, _cellHeight);
				_cells.push(rect);
			}
		}
		
		private function createTileGrid():void
		{
			var cols:Number = _bitmapData.width / _cellWidth;
			var rows:Number = _bitmapData.height / _cellHeight;
		
			for (var i:int=0; i < rows; i++)
			{
				for (var j:int=0; j < cols; j++)
				{
					var xpos:int = (j * _cellHeight);
					var ypos:int = (i * _cellWidth);
					
					var rect:Rectangle = new Rectangle(xpos, ypos, _cellWidth, _cellHeight);
					_cells.push(rect);
				}
			}
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get totalCells():int 
		{ 
			return _cells.length;
		}
		
	}

}