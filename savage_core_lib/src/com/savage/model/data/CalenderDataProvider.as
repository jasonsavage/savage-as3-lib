package com.savage.model.data
{
	import com.savage.model.vo.DataProviderVO;
	/**
	 * TODO: Document Class
	 * @author Jason Savage
	 */
	public class CalenderDataProvider extends DataProvider
	{
		public static const DAYS_IN_MONTHS:Array = [
			"31", "28", "31", "30", "31", "30", "31", "31", "31", "31", "30", "31"
		];
		
		public static const DAYS_IN_MONTHS_LEAP:Array = [
			"31", "29", "31", "30", "31", "30", "31", "31", "31", "31", "30", "31"
		];
		
		public static const MONTH_NAMES:Array = [
			"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
		];
		
		public static const MONTH_ABBREVS:Array = [
			"Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"
		];
		
		public static const MONTH_LETTERS:Array = [
			"J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"
		];
		
		public static const DAYS_NAMES:Array = [
			"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
		];
		
		public static const DAYS_ABBREVS:Array = [
			"Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"
		];
		
		public static const DAYS_LETTERS:Array = [
			"S", "M", "T", "W", "T", "F", "S"
		];
		
		public static const US_HOLIDAYS:Array = [
			"New Years", "President's day", "Easter", "Memorial day", "Independence day", "Labor day", "Thanksgiving", "Christmas"
		];
		
		/**
		 * Constructor
		 */
		public function CalenderDataProvider(source:Vector.<DataProviderVO>=null):void
		{
			super(source);
		}
		
		/**************************************
		 * Static
		 **************************************/
		
		/**
		 * Creates a CalenderDataProvider of the number of days in a givin month.
		 * @param	month
		 * @return
		 */
		public static function daysInMonth(month:Number=0, leap:Boolean=false):CalenderDataProvider
		{
			if (leap)
				return new CalenderDataProvider( getRange(1, DAYS_IN_MONTHS_LEAP[month]) );
			return new CalenderDataProvider( getRange(1, DAYS_IN_MONTHS[month]) );
		}
		
		/**
		 * Creates a CalenderDataProvider of month in a year (1 - 12).
		 * @return
		 */
		public static function monthsInYear():CalenderDataProvider
		{
			return new CalenderDataProvider( getRange(1, 12) );
		}
		
		/**
		 * Creates a CalenderDataProvider of month names.
		 * @return
		 */
		public static function monthNames():CalenderDataProvider
		{
			var data:Vector.<DataProviderVO> = new Vector.<DataProviderVO>();
			for (var i:int = 0; i < MONTH_NAMES.length; i++)
			{
				var vo:DataProviderVO = new DataProviderVO();
				vo.label = MONTH_NAMES[i];
				vo.data = i.toString();
				data.push(vo);
			}
			
			return new CalenderDataProvider(data);
		}
		
		/**
		 * Returns an array of objects containing the number of years from now till the specified yearCount.
		 * @param	yearCount
		 * @return
		 */
		public static function yearsNowTill(yearCount:Number=100):CalenderDataProvider
		{
			var now:Date = new Date();
			var start:Number = now.getFullYear();
			var end:Number = (start - yearCount);
			
			var data:Vector.<DataProviderVO> = getRange(end, start); 
			return new CalenderDataProvider(data.reverse()); //reverse becasue getRange goes low to high
		}
		
		/**
		 * Returns true or false if the year specified is a leap year.
		 * @param	year
		 * @return
		 */
		public static function isLeapYear(year:int):Boolean
		{
			return (year % 4 == 0);
		}
		
		/**
		 * Returns the last day of any givin year. (New Years eve)
		 * @param	year
		 * @return
		 */
		public static function getNewYearsEve(year:int):Date
		{
			return new Date(year, 11, 31);
		}
		
		/**
		 * Returns the 3rd Monday of February for any givin year (Presidents Day)
		 * @param	year
		 * @return
		 */
		public static function getPresidentsDay(year:int):Date
		{
			var d:Date = new Date(year, 1);
			var i:int = isLeapYear(year) ? 29 : 28;
			var mon:int = 0;
			do
			{
				d.setDate(i);
				if (d.getDay() == 1)
					mon++;
				
				if (mon > 1)
					break;
			}
			while (i--);
			
			return d;
		}
		
		/**
		 * Returns the last Monday in May for any givin year (Memorial Day)
		 * @param	year
		 * @return
		 */
		public static function getMemorialDay(year:int):Date
		{
			var d:Date = new Date(year, 4);
			var i:int = parseInt( DAYS_IN_MONTHS[4] );
			do
			{
				d.setDate(i);
				if (d.getDay() == 1)
					break;
			}
			while (i--);
			return d
		}
		
		/**
		 * Returns the 4th of July for any givin year (Independence Day)
		 * @param	year
		 * @return
		 */
		public static function getIndependenceDay(year:int):Date
		{
			var d:Date = new Date(year, 6, 4);
			return d
		}
		
		/**
		 * Returns the first Monday of September for any givin year (Labor Day)
		 * @param	year
		 * @return
		 */
		public static function getLaborDay(year:int):Date
		{
			var d:Date = new Date(year, 9);
			var i:int = 1;
			do
			{
				d.setDate(i);
				if (d.getDay() == 1)
					break;
			}
			while (i++ < 30);
			return d
		}
		
		/**
		 * Returns the fourth Thursday of November for any givin year (Thanksgiving)
		 * @param	year
		 * @return
		 */
		public static function getThanksgiving(year:int):Date
		{
			var d:Date = new Date(year, 10);
			var i:int = 1;
			var thurs:int = 0;
			do
			{
				d.setDate(i);
				if (d.getDay() == 4)
					thurs++;
				
				if (thurs > 3)
					break;
			}
			while (i++ < 30);
			return d
		}
		
		/**
		 * Returns the 25th of December for any givin year (Christmas)
		 * @param	year
		 * @return
		 */
		public static function getChristmas(year:int):Date
		{
			var d:Date = new Date(year, 11, 25);
			return d
		}
		
		/**************************************
		 * Private 
		 **************************************/
		
		private static function getRange(start:Number, end:Number):Vector.<DataProviderVO>
		{
			var data:Vector.<DataProviderVO> = new Vector.<DataProviderVO>();
			for(var i:Number = start; i <= end; i++)
			{
				var vo:DataProviderVO = new DataProviderVO();
				vo.label = i.toString();
				vo.data = i.toString();
				data.push(vo);
			}
			return data;
		}

	}
}