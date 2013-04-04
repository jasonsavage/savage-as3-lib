package com.savage.model.data 
{
	/**
	 * ...
	 * @author 
	 */
	public class Iterator 
	{
		private var _index:int;
		private var _source:Array;

				
		/**
		 * Constructor
		 */
		public function Iterator(source:Array) 
		{
			_source = source;
			_index = -1;
		}
		
		public function hasNext():Boolean
		{
			return (_index + 1 < _source.length);
		}
		
		public function next():Object
		{
			_index++;
			return _source[_index];
		}
		
		public function remove():void
		{
			_source.splice(_index, 1);
			_index--;
		}
	}

}