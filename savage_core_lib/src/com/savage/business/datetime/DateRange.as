package com.savage.business.datetime
{
	
	/**
	 * The DateRange class is used to define a span of time between two dates.
	 * @author Jason Savage
	 */
	public class DateRange 
	{
		private var _startDate:Date;
		private var _endDate:Date;
		
		public function get startDate():Date { return _startDate; }
		public function get endDate():Date { return _endDate; }
		
		/**
		 * Contructor
		 * @param	start
		 * @param	end
		 */
		public function DateRange( start:Date, end:Date) 
		{
			_startDate = start;
			_endDate = end;
		}
		
		/**
		 * Returns true if the specified date is between, or equal to either, the start and end dates.
		 * @param	value
		 * @return
		 */
		public function inRange( value:Date=null ):Boolean
		{
			value = (value) ? value : new Date();
			
			var n:Number = value.getTime();
			var s:Number = _startDate.getTime();
			var e:Number = _endDate.getTime();
			
			return (n >= s && n <= e);
		}
		
		/**
		 * Returns true if the specified date is before this date range.
		 * @param	value
		 * @return
		 */
		public function before( value:Date=null ):Boolean
		{
			value = (value) ? value : new Date();
			
			var n:Number = value.getTime();
			var s:Number = _startDate.getTime();
			
			return ( n < s );
		}
		
		/**
		 * Returns true if the specified date is after this date range.
		 * @param	value
		 * @return
		 */
		public function after( value:Date=null ):Boolean
		{
			value = (value) ? value : new Date();
			
			var n:Number = value.getTime();
			var e:Number = _endDate.getTime();
			
			return ( n > e );
		}
	}
	
}