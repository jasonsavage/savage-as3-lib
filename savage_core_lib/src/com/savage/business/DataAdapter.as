package com.savage.business 
{
	import com.savage.interfaces.IDataView;
	import com.savage.model.ApplicationProxy;
	import com.savage.model.vo.BasicVO;
	import com.savage.views.View;
	
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class DataAdapter
	{
		
		public static function populateViewClass(view:View, data:Vector.<BasicVO>, itemClass:Class):void
		{
			view.removeAllChildren();
			
			for (var i:int = 0; i < data.length; i++)
			{
				var item:IDataView = new itemClass();
				item.data =  data[i];
				
				view.addChild( item as DisplayObject );
			}
		}
		
		public static function populateView(view:View, data:Vector.<BasicVO>, factoryMethod:Function):void
		{
			view.removeAllChildren();
			
			for (var i:int = 0; i < data.length; i++)
				view.addChild( factoryMethod(data[i]) );
		}
		
		public static function populateViewWithXMLList(view:View, data:XMLList, factoryMethod:Function):void
		{
			view.removeAllChildren();
			
			for each(var ele:XML in data.elements())
			{
				view.addChild( factoryMethod(ele) );
			}	
		}
		
		public static function populateProxyWithXML(proxy:ApplicationProxy, data:XML, ItemClass:Class):Array
		{
			var retVal:Array = new Array();
			
			for each(var ele:XML in data.elements())
				retVal.push( new ItemClass(ele, proxy));
			
			return retVal;
		}
	}

}