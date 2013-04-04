package com.savage.model.vo 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	/**
	 * The BasicVO class is the base class for a Value Object (VO) 
	 * which is a simple object that holds data from an xml file.
	 * 
	 * @author Jason Savage
	 */
	public class BasicVO extends EventDispatcher
	{
		protected var _owner:Object;
		public function get owner():Object { return _owner; }
		
		/**
		 * Constructor
		 * @param	xml
		 * @param	owner
		 */
		public function BasicVO(xml:*=null, owner:Object=null) 
		{
			_owner = owner;
			
			if (xml)
			{
				for each(var attr:XML in xml.attributes())
					processXMLKeyValue(attr);
			
				for each(var ele:XML in xml.elements())
					processXMLKeyValue(ele);
			}
		}
		
		protected function processXMLKeyValue(node:XML):void 
		{ 
			var key:String = node.name().toString();
			if ( hasOwnProperty(key) )
				this[key] = node.toString();
		}
		
		public function setValue(key:String, value:Object):void
		{
			if ( hasOwnProperty(key) && this[key] != value )
			{
				this[key] = value;
				dispatchEvent( new Event(Event.CHANGE) );
			}
		}
	}

}