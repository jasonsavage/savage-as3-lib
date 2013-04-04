package com.savage.game.business
{
	import flash.utils.Dictionary;
	
	/**
	 * The PropertyManager class provides an interface to access values that change during gameplay such as score and time.
	 * It also allows you to bind callbacks to properties.
	 * @author Jason Savage
	 */
	public class PropertyManager
	{
		private static var _bindings:Dictionary = new Dictionary(true);
		private static var _properties:Dictionary = new Dictionary();
		
		/**
		 * Sets up the PropertyManager
		 * @param	levelData
		 */
		public static function setup(properties:Array):void 
		{ 
			while (properties.length)
				_properties[properties.pop()] = 0;
		}
		
		/**
		 * Sets all property values to 0.
		 */
		public static function reset():void 
		{ 
			for (var key:String in _properties)
				setValue(key, 0);
		}
		
		/**
		 * Allows you to bind a callback to a property, so when the property 
		 * changes the specified callback is called.
		 * @param	prop
		 * @param	callback
		 */
		public static function bind(prop:String, callback:Function):void
		{
			if (!_bindings[prop])
				_bindings[prop] = new Array();
				
			_bindings[prop].push( callback );
		}
		
		/**
		 * Removes a callback from a property.
		 * @param	prop
		 */
		public static function unbind(prop:String, callback:Function):void
		{
			if ( _bindings[prop] )
			{
				var i:int = _bindings[prop].indexOf( callback );
				if(i != -1 )
					_bindings[prop].splice( i, 1);
			}
		}
		
		/**
		 * Gets the value under the supplied prop.
		 * @param	prop
		 * @return
		 */
		public static function getValue(prop:String):int
		{
			if (!_properties[prop])
				_properties[prop] = 0;
			
			return _properties[prop];
		}
		
		/**
		 * Sets the value of the specified prop and calls all binding to that property.
		 * Callback signiture should be structured like: myFunction(newValue:int, oldValue:int):void
		 * @param	prop
		 * @param	value
		 */
		public static function setValue(prop:String, value:int):void
		{
			var old:int = _properties[prop];
			
			_properties[prop] = value;
			
			if (_bindings[prop])
			{
				for each(var callback:Function in _bindings[prop])
					callback.call( value, old );
			}
		}
		
		/**
		 * Updates a value under the specified prop.
		 * @param	prop
		 * @param	amount
		 */
		public static function updateValue(prop:String, amount:int):void
		{
			var value:int = getValue(prop);
			setValue(prop, value + amount);
		}
	}

}