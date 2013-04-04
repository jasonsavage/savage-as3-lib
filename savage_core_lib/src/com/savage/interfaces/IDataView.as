package com.savage.interfaces 
{
	import com.savage.model.vo.BasicVO;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IDataView 
	{
		function get data():BasicVO;
		function set data(value:BasicVO):void
	}
	
}