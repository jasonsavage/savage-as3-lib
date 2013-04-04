package com.savage.events
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class TimelineEvent extends Event
	{
		public static const START:String	= "timelineStart";
		public static const STOP:String		= "timelineStop";
		public static const COMPLETE:String	= "timelineComplete";
		
		public static const CUE_POINT:String = "cuepoint";
		
		public var movieClip:MovieClip;
		public var cuePointName:String;
		
		/**
		 * Constructor
		 * @param	type
		 * @param	movieClip
		 */
		public function TimelineEvent(type:String, movieClip:MovieClip=null, cuePointName:String="" )
		{
			super(type, true, false);
			
			this.movieClip = movieClip;
			this.cuePointName = cuePointName;
		}
		
	}
}