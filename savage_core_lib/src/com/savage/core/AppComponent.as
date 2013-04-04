package com.savage.core
{
	import com.savage.interfaces.INestedObject;
	import com.savage.interfaces.INoteSubscriber;
	import com.savage.interfaces.IUDisplayListObject;
	import com.savage.interfaces.IUPropertiesObject;
	import com.savage.managers.LayoutManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Extend the AppComponent class to give all your components access to the BaseApi of the current Application. 
	 * 
	 * @author Jason Savage
	 * @see com.savage.core.ApplicationFacade
	 * @see com.savage.core.ApplicationBase
	 */
	dynamic public class AppComponent extends Sprite implements IUDisplayListObject, IUPropertiesObject, INoteSubscriber 
	{
		/**************************************
		 * Properties
		 **************************************/
		private var _invalidateDisplayListFlag:Boolean;
		private var _invalidatePropertiesFlag:Boolean;
		private var _suppressInvalidateOnAddRemoveChild:Boolean;
		private var _nestedLevel:int = 0;
		private var _initialized:Boolean;
		private var _children:Array;
		
				
		/**
		 * Constructor
		 */
		public function AppComponent()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, on_AddedHandler);
		}
		
		/**
		 * @private
		 */
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			return addChildAt(child, numChildren);
		}
		
		/**
		 * @private
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			if (child is INestedObject)
				INestedObject(child).nestedLevel = _nestedLevel + 1;
			
			if(!_suppressInvalidateOnAddRemoveChild)
				invalidateDisplayList();
				
			return super.addChildAt(child, index);
		}
		
		/**
		 * @private
		 */
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			return removeChildAt(getChildIndex(child));
		}
		
		/**
		 * @private
		 */
		override public function removeChildAt(index:int):DisplayObject 
		{
			var child:DisplayObject = super.removeChildAt(index);
			
			if (child is INestedObject)
				INestedObject(child).nestedLevel = 0;
				
			if(!_suppressInvalidateOnAddRemoveChild)
				invalidateDisplayList();
				
			return child;
		}
		
		/**
		 * Removes all children from the display list.
		 */
		public function removeAllChildren():void
		{
			_suppressInvalidateOnAddRemoveChild = true;
			
			var i:int = numChildren;
			while(i--)
				removeChildAt(i);
				
			_suppressInvalidateOnAddRemoveChild = false;
		}
		
		/**
		 * Returns an array of all children of this component.
		 * @return
		 */
		public function getChildren():Array
		{
			var res:Array = new Array();
			for (var i:int = 0; i < numChildren; i++ )
				res[i] = getChildAt(i);
			return res;
		}
		
		/**
		 * Convenence method to send a notification to the Notification service in the facade.
		 * @param	notificationName
		 * @param	body
		 */
		public function sendNotification( name:String, body:Object=null):void 
		{
			facade.sendNotification(name, body);
		}
		
		/**
		 * Convenence method to subscribe to the Notification service in the facade.
		 */
		public function subscribeToNotifications():void
		{
			facade.subscribe(this);
		}
		
		/**
		 * Convenence method to unsubscribe to the Notification service in the facade.
		 */
		public function unsubscribeFromNotifications():void
		{
			facade.unsubscribe(this);
		}
		
		/**
		 * Returns a list of notifications that this component is interested in.
		 * @return
		 */
		public function listNotificationInterests():Array { return [ ]; }
		
		/**
		 * If the noteName is returned in the <code>listNotificationInterests()</code> method the 
		 * NotificationService will call this method to handle the current Notification being sent.
		 * @param	noteName
		 * @param	noteBody
		 */
		public function handleNotification( noteName:String, noteBody:Object):void {	}
		
		
		/**
		 * Called when this component is added to the display list of a display object.
		 */
		protected function initialize():void 
		{ 
			if (_initialized)
				return;
			
			//add all children to the stage
			createChildren();
			
			//update properties
			invalidateProperties();
			
			//update display list
			invalidateDisplayList();
			
			_initialized = true;
		}
		
		/**
		 * Called to add all children of this component to the display list.
		 */
		protected function createChildren():void { }
		
		/**
		 * Causes this component to call <code>updateDisplayList()</code> during the next update phase.
		 */
		public function invalidateDisplayList():void
		{
			if (parent && !_invalidateDisplayListFlag)
			{
				_invalidateDisplayListFlag = true;
				LayoutManager.invalidateDisplayList(this, nestedLevel);
			}
			
			if (parent && parent is IUDisplayListObject)
				IUDisplayListObject(parent).invalidateDisplayList();
		}
		
		/**
		 * Loops through the display list and updates the postion of all this component's children.
		 */
		public function updateDisplayList():void 
		{ 
			_invalidateDisplayListFlag = false;
		}
		
		/**
		 * Causes this component to call <code>updateDisplayList()</code> during the next update phase.
		 */
		public function invalidateProperties():void
		{
			if (parent && !_invalidatePropertiesFlag)
			{
				_invalidatePropertiesFlag = true;
				LayoutManager.invalidateProperties(this, nestedLevel);
			}
			
			if (parent && parent is IUPropertiesObject)
				IUPropertiesObject(parent).invalidateProperties();
		}
		
		/**
		 * Loops through the display list and updates the postion of all this component's children.
		 */
		public function updateProperties():void 
		{ 
			_invalidatePropertiesFlag = false;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		/**
		 * @private
		 */
		private function on_AddedHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, on_AddedHandler);
			initialize();
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		/**
		 * @private
		 */
		protected function get initialized():Boolean { return _initialized; }
		protected function get facade():ApplicationFacade
		{ 
			return ApplicationFacade.getInstance(); 
		}
		 
		public function get position():Point { return new Point(x, y); }
		public function set position(value:Point):void
		{
			x = value.x;
			y = value.y;
		}

		public function get unScaledWidth():Number
		{
			return (scaleX == 1) ? width : width / Math.abs(scaleX);
		}
		public function get unScaledHeight():Number
		{
			return (scaleY == 1) ? height : height / Math.abs(scaleY);
		}

		public function get scale():Number { return scaleX; }
		public function set scale(value:Number):void
		{
			scaleX = scaleY = value;
		}
		
		public function get center():Point
		{
			return new Point((width * 0.5), (height * 0.5));
		}
		
		/**
		 * @private
		 */
		public function get nestedLevel():int { return _nestedLevel; }
		public function set nestedLevel(value:int):void
		{
			_nestedLevel = value;
		}
		
		public function get suppressInvalidateOnAddRemoveChild():Boolean { return _suppressInvalidateOnAddRemoveChild; }
		public function set suppressInvalidateOnAddRemoveChild(value:Boolean):void
		{
			_suppressInvalidateOnAddRemoveChild = value;
		}
	}
	
}