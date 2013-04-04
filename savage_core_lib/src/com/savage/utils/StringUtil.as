package com.savage.utils
{
	/**
	 * TODO: Document Method
	 * @author Jason Savage
	 */
	public class StringUtil
	{
		/**
		 * Replaces {0},{1},{2} with the values in ...args
		 * @param	message
		 * @param	...args
		 * @return
		 */
		public static function format(message:String, ...args):String
		{
			for(var i:Number = 0; i < args.length; i++)
			{
				message = message.replace("{"+i+"}", args[i]);
			}
			return message;
		}
		
		/**
		 * Removes all the values in ...args from the message
		 * @param	message
		 * @param	...args
		 * @return
		 */
		public static function removeCharacters(message:String, ...args):String
		{
			for(var i:Number = 0; i < args.length; i++)
			{
				var pattern:RegExp = new RegExp("\\" + args[i], "g");
				message = message.replace(pattern, "");
			}
			return message;
		}
		
		public static function removeAllSymbols(message:String):String
		{
			var chrs:String = "(~`!@#$%^&*()_-+={[}]|\\:;\"'<,>.?/)*";
			
			for(var i:Number = 0; i < chrs.length; i++)
				message = message.replace(chrs.charAt(i), "");
				
			return message;
		}
		
		public static function encodeQuotes(value:String):String
		{
			var quots:RegExp = /(&quot;)|"|(&ldquo;)|“|(&rdquo;)|”/g;
			var apos:RegExp = /(&apos;)|'/g;
			
			value = value.replace(quots, "&#34;");
			value = value.replace(apos, "&#39;");
			return value;
		}
		
		public static function decodeQuotes(value:String):String
		{
			var quots:RegExp = /(&#34;)/g;
			var apos:RegExp = /(&#39;)/g;
			
			value = value.replace(quots, "\"");
			value = value.replace(apos, "'");
			return value;
		}
		
		/**
		 * Removes all whitespaces before and after the value.
		 * @param	value
		 * @return
		 */
		public static function trim(value:String):String 
		{
			var pattern:RegExp = /^\s+|\s+$/g;
			return value.replace(pattern, "");
		}
		
		public static function truncate(value:String, length:int=0):String 
		{
			if (value.length <= length)
				return value;
				
			return value.substring(0, length) + "...";
		}
		
		/**
		 * Capitalizes the first character in the value.
		 * @param	value
		 * @return
		 */
		public static function capFirstLetter(value:String):String 
		{
			return value.charAt(0).toUpperCase() + value.substr(1);
		}
		
		/**
		 * Capitalizes the first character in all of the words in the value. If removeSpaces is true all spaces are removed from value.
		 * @param	value
		 * @param	removeSpaces 
		 * @return
		 */
		public static function toCamelCase(value:String, removeSpaces:Boolean=true):String 
		{
			var words:Array = value.split(" ");
			for(var i:Number = 0; i < words.length; i++)
			{
				words[i] = StringUtil.capFirstLetter( words[i] );
			}
			return (removeSpaces)? words.join("") : words.join(" ");
		}
		
		/**
		 * Removes all whitespace characters from the value.
		 * @param	value
		 * @return
		 */
		public static function removeMuliWhiteSpaces(value:String):String
		{
			var pattern:RegExp = /[ ]{2,}/g; 
			return value.replace(pattern, " ");
		}
		
		/**
		 * Reverses the value.
		 * @param	value
		 * @return
		 */
		public static function reverse(value:String):String
		{
			return value.split('').reverse().join('');
		}
		
		/**
		 * Reverses the words in the value order.
		 * @param	value
		 * @return
		 */
		public static function reverseWords(value:String):String
		{
			return value.split(' ').reverse().join(' ');
		}
		
		/**
		 * Removes a specified character from the value.
		 * @param	char
		 * @param	value
		 * @return
		 */
		public static function removeChar(char:String, value:String):String
		{
			var pattern:RegExp = new RegExp(char.charAt(0), "g"); 
			return value.replace(pattern, "");
		}
		
		/**
		 * Removes all xml tags from value.
		 * @param	value
		 * @return
		 */
		public static function stripTags(value:String) : String
        {
			var pattern:RegExp = /<\/?[^>]+>/igm;
            return value.replace(pattern, "");
        }
		
		/**
		 * Checks to see if the search value is in value.
		 * @param	value
		 * @param	find
		 * @return
		 */
		public static function contains(value:String, search:String) : Boolean
        {
            return (value.indexOf(search) != -1);
        }
		
		/**
		 * Counts the number of words in the supplied value.
		 * @param	value
		 * @return
		 */
		public static function wordCount(value:String) : Number
        {
			var pattern:RegExp = /\b\w+\b/g;
            return value.match(pattern).length;
        }
		
		/**
		 * Removes the following characters from the value: . ( ) - [space]
		 * @param	value
		 * @return
		 */
		public static function stripPhoneFormat(value:String):String
		{ 
			var pattern:RegExp = /[\.\(\)\-\s]?/g; 
			return value.replace(pattern, "");
		}
		
		/**
		 * Generates a random code of letters and numbers.
		 * @param	length
		 * @return
		 */
		public static function generateCode(length:int=5):String
		{
			var code:String = "";
			var chars:String = "abcdefghjklmnprstuvwxyz23456789"; //removed i10oq
			
			while (length--)
			{
				var i:int = Math.random() * chars.length;
				code += chars.charAt(i);
			}
			
			return code.toUpperCase();
		}
	}
}