package com.savage.business.datetime
{
	
	/**
	 * This class creates an Array of random dates.
	 */
	public class RandomDateList
	{
		public var startDate:Date;
		public var endDate:Date;
		
		public var source:Array;
		
		private var blackouts:Array;
		private var count:Number;
		private var requiresRefreash:Boolean;
		
		/**
		 * Constructor
		 * 
		 * @param start		The date to start with.
		 * @param end		The date to end on.
		 * @param length	How many random dates between the start and end dates to generate.
		 */
		public function RandomDateList(start:Date, end:Date, length:Number)
		{
			this.startDate 	= start;
			this.endDate 	= end;
			this.count		= length;
			this.requiresRefreash = false;
			
			this.source 	= new Array();
			this.blackouts 	= new Array();
			
			this.refresh();
		}
		
		/**
		 * Used to add a chunk of time when dates should not be generated
		 * 
		 * @param start		The date the blackout starts on.
		 * @param end		The date the blackout ends on.
		 */
		public function addBlackoutDate(start:Date, end:Date):void
		{
			var b:BlackoutDate = new BlackoutDate(start, end);
			this.blackouts.push(b);
			
			this.requiresRefreash = true;
		}
		
		/**
		 * Used to remove a chunk of time that was added with <code>addBlackoutDate()</code>
		 * 
		 * @param start		The date the blackout starts on.
		 * @param end		The date the blackout ends on.
		 */
		public function removeBlackoutDateAt(index:Number):void
		{
			if(index >= this.blackouts.length) return;
			this.blackouts.splice(index, 1);
			
			this.requiresRefreash = true;
		}
		
		/**
		 * Returns a string of all the values in source
		 */
		public function toString():String
		{
			if(this.requiresRefreash)
			{
				this.refresh();
				
			}
			
			var str:String = "";
			for(var i:Number = 0; i < this.source.length; i++)
			{
				str += this.source[i].toLocaleString() + "\n";
			}
			return str;
		}
		
		public function get length():Number
		{
			return this.source.length;
		}
		
		/**
		 * @private
		 */
		 
		 /**
		 * This method is called automatically by constructor but needs to be called again if any blackout dates are added/removed.
		 */
		private function refresh():void
		{
			for(var i:Number = 0; i <= this.count; i++)
			{
				var d:Date = this.getRandomDate();
				d.setSeconds(0,0);
				
				var res:Boolean = this.isDuringBlackout( d );
				var res2:Boolean = this.isDuplicateDate( d );
				
				if(!res && !res2)
				{
					this.source.push( d );
				}
				else
				{
					i--;
				}
			}
			this.source.sort(this.sortOnDate);
			this.requiresRefreash = false;
		}
		
		private function getRandomDate():Date
		{
			var span:Number = (this.endDate.time - this.startDate.time);
			return new Date( this.startDate.time + (Math.random() * span) );
		}

		private function isDuringBlackout(date:Date):Boolean
		{
			if(this.blackouts.length <= 0) return false;
			
			for(var i:Number = 0; i < this.blackouts.length; i++)
			{
				var b:BlackoutDate = blackouts[i] as BlackoutDate;
				if( b.isDuringBlackout( date ) )
				{
					return true;
				}
			}
			return false;
		}

		private function isDuplicateDate(date:Date):Boolean
		{
			if(this.source.length <= 0) return false;
			
			for(var i:Number = 0; i < this.source.length; i++)
			{
				var d:Date = this.source[i] as Date;
				
				if(date.time == d.time)
				{
					return true;
				}
			}
			return false;
		}
		
		private function sortOnDate(a:Date, b:Date):Number 
		{
		    var aTime:Number = a.time;
		    var bTime:Number = b.time;
		
		    if(aTime > bTime) 
		    {
		        return 1;
		    }
		    else if(aTime < bTime) 
		    {
		        return -1;
		    } 
		    else  
		    {
		        return 0;
		    }
		}

	}
}

class BlackoutDate
{
	public var startDate:Date;
	public var endDate:Date;
		
	public function BlackoutDate(start:Date, end:Date)
	{
		this.startDate 	= start;
		this.endDate	= end;
	}
	public function isDuringBlackout(date:Date):Boolean
	{
		var time:Number = date.time;
		return (time >= this.startDate.time && time <= this.endDate.time);
	}
}