package com.savage.managers
{
	import com.savage.interfaces.INoteSubscriber;
	import flash.utils.Dictionary;
	
	/**
	 * The NotificationManager class allows objects to publish/subscribe to notifications sent by other objects.
	 * @author Jason Savage
	 */
	public class NotificationManager
	{
		
		private var _subscriberMap:Dictionary;
		
		/**
		 * Constructor
		 */
		public function NotificationManager()
		{
			_subscriberMap = new Dictionary(true);
		}
		
		/**
		 * Subscribes the specified object as a subscriber.
		 * @param	subscriber
		 */
		public function subscribe(subscriber:INoteSubscriber):void
		{
			_subscriberMap[subscriber.name] = subscriber;
		}
		
		/**
		 * Unsubscribes the specified object and prevents any further notification from reaching this object.
		 * @param	subscriber
		 */
		public function unsubscribe(subscriber:INoteSubscriber):void
		{
			_subscriberMap[subscriber.name] = null;
		}
		
		/**
		 * Sends a notification through the list of subscribers.
		 * @param	noteName
		 * @param	noteBody
		 */
		public function sendNotification(noteName:String, noteBody:Object=null):void
		{
			for each(var sub:INoteSubscriber in _subscriberMap)
			{
				var a:Array = sub.listNotificationInterests();
				if (a.indexOf(noteName) != -1)
					sub.handleNotification(noteName, noteBody);
			}
		}
		
	}

}