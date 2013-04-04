package com.savage.model.data 
{
	import com.savage.model.vo.DataProviderVO;
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class DataProvider 
	{
		private var _source:Vector.<DataProviderVO>;
		
		/**
		 * Constructor
		 * @param	source
		 */
		public function DataProvider( source:Vector.<DataProviderVO> = null) 
		{
			_source = source;
		}
		
		public function getItemAt(index:int):DataProviderVO
		{
			return _source[index];
		}
		
		public function addItemAt(item:DataProviderVO, index:int):void
		{
			_source.splice(index, 0, item);
		}
		
		public function removeItemAt(index:int):void
		{
			_source.splice(index, 1);
		}
		
		public function removeAll():void
		{
			_source.length = 0;
		}
		
		public function get length():int { return _source.length; }
		
		public function get source():Vector.<DataProviderVO> { return _source; }
		public function set source(value:Vector.<DataProviderVO>):void
		{
			_source = value;
		}
		
		/**************************************
		 * Static
		 **************************************/
		
		/**
		 * Creates a Vector array out the 2 specified arrays for use with a DataProvider
		 * @param	labels
		 * @param	datas
		 * @return
		 */
		public static function merge(labelsArray:Array, datasArray:Array = null):Vector.<DataProviderVO>
		{
			//populate provider
			var data:Vector.<DataProviderVO> = new Vector.<DataProviderVO>();
			for (var i:int = 0; i < labelsArray.length; i++)
			{
				var vo:DataProviderVO = new DataProviderVO();
				vo.label = labelsArray[i];
				vo.data = (datasArray) ? datasArray[i] : i.toString();
				data.push(vo);
			}
			
			return data;
		}
	}

}