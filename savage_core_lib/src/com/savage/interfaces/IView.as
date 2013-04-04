package com.savage.interfaces 
{
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public interface IView extends IMeasurable
	{
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get top():Object;
		function set top(value:Object):void;
		
		function get right():Object;
		function set right(value:Object):void;
		
		function get bottom():Object;
		function set bottom(value:Object):void;
		
		function get left():Object;
		function set left(value:Object):void;
		
		function get horizontalCenter():Object;
		function set horizontalCenter(value:Object):void;
		
		function get verticalCenter():Object;
		function set verticalCenter(value:Object):void;
	}
	
}