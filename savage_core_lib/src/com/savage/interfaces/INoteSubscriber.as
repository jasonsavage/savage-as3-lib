package com.savage.interfaces
{
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public interface INoteSubscriber 
	{
		function get name():String
		function set name(value:String):void
		
		function listNotificationInterests():Array 
		function handleNotification( noteName:String, noteBody:Object):void
	}
	
}