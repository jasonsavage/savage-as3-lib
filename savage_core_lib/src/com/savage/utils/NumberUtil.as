package com.savage.utils 
{
	/**
	 * The NumberUtil class contains static methods for formating with numbers.
	 * @author Jason Savage
	 */
	public class NumberUtil 
	{
		
		/**
		 * Adds specified number of zeros to the end of the supplied number.
		 * @param	value
		 * @param	places
		 * @return
		 */
		public static function zerosAppend(value:Number, places:Number=2):String
		{
			var str:String = "";
		  	for (var i:Number = 0; i < places; i++) 
		  	{
				str += "0";
		  	}
		  	
		  	return value.toString() + str;
		}
		
		/**
		 * Adds a specified number of zeros to the beginning of the supplied number.
		 * @param	value
		 * @param	places
		 * @return
		 */
		public static function zeroPrepend(value:Number, places:Number=2):String
		{
			var str:String = "";
		  	for (var i:Number = 0; i < places; i++) 
		  	{
				str += "0";
		  	}
		  	
		  	return str + value.toString();
		}
		
		/**
		 * Adds a 0 to the front of a number if the number is below 10.
		 * @param	value
		 * @return
		 */
		public static function zeroPad(value:Number):String
		{
			if(value < 10)
			{
				return zeroPrepend(value, 1);
			}
			return value.toString();
		}
		
		/**
		 * Retuns the supplied seconds as a timecode formated string (HH:MM:SS.MS).
		 * @param	seconds
		 * @return
		 */
		public static function timecode(seconds:Number):String
		{
			var m:Number	= Math.floor(seconds/60);
			var rs:Number	= seconds % 60;
			var rm:Number	= m % 60;
			var h:Number	= Math.floor(m/60);
			var fs:Number 	= Math.floor((rs - Math.floor(rs))*100);
			
			rs = Math.floor(rs);
			
			return StringUtil.format("{0}:{1}:{2}.{3}", zeroPad(h), zeroPad(rm), zeroPad(rs), zeroPad(fs));
		}
		
		/**
		 * Retuns the supplied seconds as a timecode formated string of minutes and seconds only.
		 * @param	seconds
		 * @return
		 */
		public static function timecodeMS(seconds:Number):String
		{
			var t:String = timecode(seconds);
			return t.substring( t.indexOf(":")+1, t.indexOf(".") );
		}
		
		/**
		 * Checks if the supplied value is a number.
		 * @param	value
		 * @return
		 */
		public static function isNumeric(value:String) : Boolean
        {
            var pattern:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return pattern.test(value);
        }
		
		/**
		 * Simple method for adding US currency format to a number ( 34 -> $34.00 )
		 * @param	value
		 * @return
		 */
		public static function formatCurrency(value:Number):String
		{ 
			var str:String = value.toString();
			if(str.indexOf(".") == -1)
			{
				str = str + ".00";
			}
			else
			{
				var arr:Array = str.split(".");
				if(arr[1].length > 1)
				{
					arr[1] = String(arr[1]).substr(0, 1);
				}
				else if(arr[1].length <= 1)
				{
					arr[1] += "0";
				}
				str = arr.join(".");
			}
			
			return str;
		}
		
		/**
		 * Adds a comma after each set of 3 numbers groups in the specified number.
		 * Ex. 9999 -> 9,999
		 * @param	num
		 * @return 
		 */
		public static function addCommasToNumber(value:Number, round:Boolean=true):String
		{
			var dec:String = "";
			var numStr:String;
			if (!round)
			{
				numStr = value.toString();
				if(numStr.indexOf(".") != -1)
					dec = "." + numStr.split(".").pop();
			}

			value = Math.floor(value);
			numStr = value.toString();
			
			var str:String = "";
			var len:int = numStr.length;

			for (var i:int = 0; i < len; i++)
			{
				if (((len - i) % 3 ) == 0 && i != 0)
					str += ",";
				
				str += numStr.charAt(i);
			}
			
			return str + dec;
		}
		
		/**
		 * Formats a number to a percent string.
		 * Ex. 0.89876 -> 89.876%
		 * @param	value
		 * @return
		 */
		public static function decimalToPercent(value:Number):String
		{
			value = value * 100;
			return value + "%";
		}
		
		/**
		 * Parses a percent string into a decimal number.
		 * @param	value
		 * @return
		 */
		public static function percentToDecimal(value:String):Number
		{
			var i:int = value.indexOf("%");
			if (i != -1)
				value = value.substring(0, i);
				
			var num:Number = parseFloat(value);
			num /= 100;
				
			return num;
		}
		
		/**
		 * Returns a Globally Unique Identifier (GUID) as a 32 character string with 5 sections, separated by a "-" symbol, containing random number/letters combos.
		 * The sections are of these lengths 8,4,4,4,12.
		 * @return 
		 */
		public static function getGUID():String
		{
			var letters:String = "ABCDEFGHIJKLMNOPQURSTUVWXYZ";
			var numbers:String = "1234567890";
		
			var res:String = "";
			var i:Number = 32;
			while (i--)
			{
				if (Math.random() > 0.5)
					res += letters.charAt(Math.random() * letters.length);
				else	
					res += numbers.charAt(Math.random() * numbers.length);
			}
			
			return res.substr(0, 8) + "-" + res.substr(8, 4) + "-" + res.substr(12, 4) + "-" + res.substr(16, 4) + "-" + res.substr(20);
		}
		
		public static function MSToSeconds(value:Number):Number
		{
			return value/1000;
		}
		
		public static function MSToMinutes(value:Number):Number
		{
			return  MSToSeconds(value) / 60;
		}
		
		public static function MSToHours(value:Number):Number
		{
			return  MSToMinutes(value) / 60;
		}
		
		public static function MSToDays(value:Number):Number
		{
			return  MSToHours(value) / 24;
		}
		
		public static function secondsToMS(value:Number):Number
		{
			return value * 1000;
		}
		
		public static function minutesToMS(value:Number):Number
		{
			return  secondsToMS(value) * 60;
		}
		
		public static function hoursToMS(value:Number):Number
		{
			return  minutesToMS(value) * 60;
		}
		
		public static function daysToMS(value:Number):Number
		{
			return  hoursToMS(value) * 60;
		}
	}

}