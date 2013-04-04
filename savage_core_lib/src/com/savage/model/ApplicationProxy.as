package com.savage.model 
{
	import com.savage.core.ApplicationFacade;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * The ApplicationProxy class setups a basic Proxy class.
	 * @author Jason Savage
	 */
	
	public class ApplicationProxy extends EventDispatcher
	{
		protected var _data:Object;
		
		/**
		 * Constructor
		 */
		public function ApplicationProxy( data:Object=null ) 
		{
			super();
			_data = data;
		}
		
		public function hasValue(key:String):Boolean
		{
			return ( _data && _data[key] );
		}
		
		public function getValue(key:String):Object
		{
			return _data[key];
		}
		
		public function setValue(key:String, value:Object):void
		{
			_data[key] = value;
		}
		
		public function getData():Object 
		{ 
			return _data; 
		}
		
		public function get facade():ApplicationFacade 
		{ 
			return ApplicationFacade.getInstance();
		}
	}

}