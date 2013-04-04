package com.savage.utils 
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ColorUtil
	{
		
		public static function changeBrightness(obj:DisplayObject, value:int):void
		{
			var trans:ColorTransform = obj.transform.colorTransform;
			trans.redOffset   = value;
			trans.greenOffset = value;
			trans.blueOffset  = value;

			obj.transform.colorTransform = trans;
		}
		
		public static function changeColor(obj:DisplayObject, value:int):void 
		{
			var trans:ColorTransform = obj.transform.colorTransform;
			trans.color = value;
			
			obj.transform.colorTransform = trans;
		}
		
	}

}