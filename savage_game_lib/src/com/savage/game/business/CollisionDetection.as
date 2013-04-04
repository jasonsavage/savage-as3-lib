package com.savage.game.business 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class CollisionDetection
	{
		
		public static function checkForRectCollision(bounds1:Rectangle, bounds2:Rectangle):Boolean
		{
			if (((bounds1.right < bounds2.left) 
					|| (bounds2.right < bounds1.left)) 
					|| ((bounds1.bottom < bounds2.top) 
					|| (bounds2.bottom < bounds1.top)) ) 
			{
				return false;
			}

			var bounds:Object = {};
			bounds.left 	= Math.max(bounds1.left, bounds2.left);
			bounds.right	= Math.min(bounds1.right, bounds2.right);
			bounds.top 		= Math.max(bounds1.top, bounds2.top);
			bounds.bottom 	= Math.min(bounds1.bottom, bounds2.bottom);

			var w:Number = bounds.right - bounds.left;
			var h:Number = bounds.bottom - bounds.top;

			if(w < 1 || h < 1)
			{
				return false;
			}
			
			return true;
		}
		
		
		public static function checkForCollision(firstObj: DisplayObject,secondObj: DisplayObject):Rectangle
		{
			var bounds1:Object = firstObj.getBounds(firstObj.root);
			var bounds2:Object = secondObj.getBounds(secondObj.root);

			if (((bounds1.right < bounds2.left) || (bounds2.right < bounds1.left)) || ((bounds1.bottom < bounds2.top) || (bounds2.bottom < bounds1.top)) ) 
			{
				return null;
			}

			var bounds:Object = {};
			bounds.left = Math.max(bounds1.left,bounds2.left);
			bounds.right= Math.min(bounds1.right,bounds2.right);
			bounds.top = Math.max(bounds1.top,bounds2.top);
			bounds.bottom = Math.min(bounds1.bottom,bounds2.bottom);

			var w:Number = bounds.right-bounds.left;
			var h:Number = bounds.bottom-bounds.top;

			if(w < 1 || h < 1)
			{
				return null;
			}

			var bitmapData:BitmapData = new BitmapData(w,h,false);

			var matrix:Matrix = firstObj.transform.concatenatedMatrix;
			matrix.tx -= bounds.left;
			matrix.ty -= bounds.top;
			bitmapData.draw(firstObj, matrix, new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));

			matrix = secondObj.transform.concatenatedMatrix;
			matrix.tx -= bounds.left;
			matrix.ty -= bounds.top;
			bitmapData.draw(secondObj, matrix, new ColorTransform(1, 1, 1, 1, 255, 255, 255, 255), BlendMode.DIFFERENCE);

			var intersection:Rectangle = bitmapData.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);

			/*try{
			bitmapData.dispose();
			}catch(e:Error){}*/

			if (intersection.width == 0) { return null; }

			intersection.x += bounds.left;
			intersection.y += bounds.top;

			return intersection;
		}
	}
}