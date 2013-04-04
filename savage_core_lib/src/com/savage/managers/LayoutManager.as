package com.savage.managers
{
	import com.savage.interfaces.IUDisplayListObject;
	import com.savage.interfaces.IUPropertiesObject;
	
	import flash.display.Shape;
	import flash.events.Event;
	
	
	/**
	 * Simple class to handle calling <code>updateProperties()</code> and <code>updateDisplayList()</code> on all invalid 
	 * AppComponent on the screen.
	 * @author Jason Savage
	 */
	public class LayoutManager
	{
		private static var _validatePendingFlag:Boolean;
		private static var _shape:Shape = new Shape();
		
		private static var _invalidateDisplayListQueue:Array = new Array();
		private static var _invalidatePropertiesQueue:Array = new Array();
		
		/**
		 * Adds the AppComponent to the DisplayList Queue to be updated during the next update phase.
		 * @param	component
		 * @param	nestedLevel
		 */
		public static function invalidateDisplayList(component:IUDisplayListObject, nestedLevel:int):void
		{
			if (!_invalidateDisplayListQueue[nestedLevel])
				_invalidateDisplayListQueue[nestedLevel] = new Array();
			
			//check if the component is listed under that level
			if (_invalidateDisplayListQueue[nestedLevel].indexOf(component) == -1)
				_invalidateDisplayListQueue[nestedLevel].push(component);
			
			//start timer
			startTimeout();
		}
		
		public static function invalidateProperties(component:IUPropertiesObject, nestedLevel:int):void
		{
			if (!_invalidatePropertiesQueue[nestedLevel])
				_invalidatePropertiesQueue[nestedLevel] = new Array();
			
			//check if the component is listed under that level
			if (_invalidatePropertiesQueue[nestedLevel].indexOf(component) == -1)
				_invalidatePropertiesQueue[nestedLevel].push(component);
			
			//start timer
			startTimeout();
		}
		
		/**************************************
		 * Private
		 **************************************/
		
		private static function startTimeout():void
		{
			if (!_validatePendingFlag)
			{
				_validatePendingFlag = true;
				_shape.addEventListener(Event.ENTER_FRAME, validate);
			}
		}
		 
		private static function validate(event:Event):void
		{
			//clear listener
			_shape.removeEventListener(Event.ENTER_FRAME, validate);
			
			//validate all component's properties
			validateProperties();
			
			//validate all Display lists
			validateDisplayLists();
			
			//reset queue
			_invalidatePropertiesQueue.length = 0;
			_invalidateDisplayListQueue.length = 0;
			
			//set pending flag to false
			_validatePendingFlag = false;
		}
		
		/**
		 * Calls <code>updateProperties()</code> on all components in the DisplayList Queue 
		 * moving from least nested to most.
		 */
		private static function validateProperties():void
		{
			//trace("validateProperties----------------------");
			for(var i:int = 0; i < _invalidatePropertiesQueue.length; i++)
			{
				//trace("validate nestedLevel " + i);
				var queue:Array = _invalidatePropertiesQueue[i];
				if (!queue) continue;
				for (var j:int = 0; j < queue.length; j++ )
				{
					//update all children at this level
					IUPropertiesObject(queue[j]).updateProperties();
					//trace("validate " + queue[j]);
				}
			}
		}
		
		/**
		 * Calls <code>updateDisplayList()</code> on all components in the DisplayList Queue 
		 * moving from most nested to least
		 */
		private static function validateDisplayLists():void
		{
			//trace("validateDisplayLists----------------------");
			var i:int = _invalidateDisplayListQueue.length;
			while(i--)
			{
				//trace("validate nestedLevel " + i);
				var queue:Array = _invalidateDisplayListQueue[i];
				if (!queue) continue;
				for (var j:int = 0; j < queue.length; j++ )
				{
					//update all children at this level
					IUDisplayListObject(queue[j]).updateDisplayList();
					//trace("validate " + queue[j]);
				}
			}
		}
	}

}