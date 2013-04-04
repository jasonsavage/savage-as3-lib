package com.savage.model.data 
{
	/**
	 * The StringBuffer class is used to process string values.
	 * @author 
	 */
	public class StringBuffer 
	{
		private var _source:String;
		
		/**
		 * Constructor
		 */
		public function StringBuffer(source:String) 
		{
			_source = source;
		}
		
		public function clone():String
		{
			return new String(_source);
		}
		
		/**
		 * Replaces all the tokens in the buffer with the matching values specified.
		 * @param	message
		 * @param	...args
		 * @return
		 */
		public function format(...args):void
		{
			for(var i:Number = 0; i < args.length; i++)
				_source = _source.replace("{"+i+"}", args[i]);
		}
		
		/**
		 * Removes all the values in ...args from the buffer
		 * @param	message
		 * @param	...args
		 * @return
		 */
		public function removeChars(...args):void
		{
			for(var i:Number = 0; i < args.length; i++)
			{
				var pattern:RegExp = new RegExp("\\" + args[i], "g");
				_source = _source.replace(pattern, "");
			}
		}
		
		/**
		 * Removes all symbols from the buffer.
		 */
		public function removeAllSymbols(symbols:String="(~`!@#$%^&*()_-+={[}]|\\:;\"'<,>.?/)*"):void
		{
			for(var i:Number = 0; i < symbols.length; i++)
				_source = _source.replace(symbols.charAt(i), "");
		}
		
		/**
		 * Removes all whitespaces before and after the value.
		 * @param	value
		 * @return
		 */
		public function trim():void 
		{
			var pattern:RegExp = /^\s+|\s+$/g;
			_source = _source.replace(pattern, "");
		}
		
		/**
		 * Shortens the buffer to the specified length and adds "..." at the end
		 * @param	length
		 */
		public function truncate(length:int=0):void 
		{
			if (_source.length > length)
			{
				var str:String = _source.substring(0, length);
				if (str.charAt(str.length-1) == " ")
					str = str.substring(0, str.length - 1);
				_source = str + "...";
			}
		}
		
		/**
		 * Capitalizes the first character in the buffer.
		 */
		public function capFirstLetter():void 
		{
			_source = _source.charAt(0).toUpperCase() + _source.substr(1);
		}
		
		/**
		 * Returns the buffer in all upper case.
		 * @return
		 */
		public function toUpperCase():String
		{
			return _source.toUpperCase();
		}
		
		/**
		 * Returns the buffer in all lower case.
		 * @return
		 */
		public function toLowerCase():String
		{
			return _source.toLowerCase();
		}
		
		/**
		 * Capitalizes the first character in all of the words and removes all spaces in the buffer. 
		 * @param	removeSpaces 
		 */
		public function toCamelCase():String 
		{
			var words:Array = _source.split(" ");
			for (var i:Number = 0; i < words.length; i++)
				words[i] = words[i].charAt(0).toUpperCase() + words[i].substr(1);
			return words.join("");
		}
		
		/**
		 * Capitalizes the first character in all of the words in the buffer.
		 * @return
		 */
		public function toCapCase():String 
		{
			var words:Array = _source.split(" ");
			for (var i:Number = 0; i < words.length; i++)
				words[i] = words[i].charAt(0).toUpperCase() + words[i].substr(1);
			return words.join(" ");
		}
		
		/**
		 * Removes all whitespace charaters from the buffer.
		 */
		public function removeWhiteSpaces():void
		{
			var pattern:RegExp = /\s?/g; 
			_source = _source.replace(pattern, "");
		}
		
		/**
		 * Removes all multiple whitespace characters from the buffer.
		 * @param	value
		 * @return
		 */
		public function removeMuliWhiteSpaces():void
		{
			var pattern:RegExp = /\s+/g; 
			_source = _source.replace(pattern, " ");
		}
		
		/**
		 * Reverses the value.
		 * @param	value
		 * @return
		 */
		public function reverse():void
		{
			_source = _source.split('').reverse().join('');
		}
		
		/**
		 * Reverses the order of the words in the buffer.
		 * @param	value
		 * @return
		 */
		public function reverseWords():void
		{
			_source = _source.split(' ').reverse().join(' ');
		}
		
		/**
		 * Removes a specified character from the buffer.
		 * @param	char
		 * @param	value
		 * @return
		 */
		public function removeChar(char:String):void
		{
			var pattern:RegExp = new RegExp(char.charAt(0), "g"); 
			_source = _source.replace(pattern, "");
		}
		
		/**
		 * Removes all xml tags from the buffer.
		 * @param	value
		 * @return
		 */
		public function stripTags():void
        {
			var pattern:RegExp = /<\/?[^>]+>/igm;
            _source = _source.replace(pattern, "");
        }
		
		/**
		 * Returns true if the buffer contains the search string
		 * @param	search
		 * @return
		 */
		public function contains(search:String) : Boolean
        {
            return (_source.indexOf(search) != -1);
        }
		
		/**
		 * Returns the number of charaters in the buffer.
		 * @return
		 */
		public function count() : Number
        {
            return _source.length;
        }
		
		/**
		 * Returns the number of words in the buffer.
		 * @return
		 */
		public function countWords() : Number
        {
            return _source.split(" ").length;
        }
		
		/**
		 * Adds the specifed value to the end of the buffer.
		 * @param	value
		 */
		public function append(value:String):void
		{
			_source += value;
		}
		
		/**
		 * Adds a space before the value and adds it to the end of the buffer.
		 * @param	value
		 */
		public function appendWord(value:String):void
		{
			append(" " + value);
		}
		
		/**
		 * Add the specifed value to the beginning of the buffer.
		 * @param	value
		 */
		public function prepend(value:String):void
		{
			_source = value + _source;
		}
		
		/**
		 * Adds a space after the value and adds it to the beginning of the buffer.
		 * @param	value
		 */
		public function prependWord(value:String):void
		{
			prepend(value + " ");
		}

		/**
		 * Inserts the specified value into the buffer at the specifed index.
		 * @param	index
		 * @param	value
		 */
		public function insert(value:String, index:int):void
		{
			_source = _source.slice(0, index) + value + _source.slice(index);
		}
		
		/**
		 * Removes the characters between the start and end index's
		 * @param	start
		 * @param	end
		 */
		public function remove(start:int, end:int=-1):void
		{
			end = (end != -1) ? end : _source.length;
			_source = _source.slice(0, start) + _source.slice(end);
		}
		
		/**
		 * Removes the character at the specifed index.
		 * @param	index
		 */
		public function removeCharAt(index:int):void
		{
			_source = _source.replace(_source.charAt(index), "");
		}
		
		/**
		 * Removes the word a the specified index.
		 * @param	index
		 */
		public function removeWordAt(index:int):void
		{
			var words:Array = _source.split(" ");
			if (index < words.length)
			{
				words.splice(index, 1);
				_source = words.join(" ");
			}
		}
		
		/**
		 * Get the worrd at the specified index in the buffer.
		 * @param	index
		 * @return
		 */
		public function getWordAt(index:int):String
		{
			var words:Array = _source.split(" ");
			if (index < words.length)
				return words[index];
			return "";
		}
		
		/**
		 * Appends the supplied arguments to the end of the buffer.
		 * @param	... args
		 * @return
		 */
		public function concat(... args):void
		{
			_source = _source.concat.apply(this, args);
		}
		
		public function concatWords(... args):void
		{
			for (var i:int = 0; i < args.length; i++)
				appendWord(args[i]);
		}
		
		/**
		 * Retruns the index of the specified value.
		 * @param	value
		 * @return
		 */
		public function indexOf(value:String):int
		{
			return _source.indexOf(value);
		}
		
		/**
		 * Returns the buffer.
		 * @return
		 */
		public function toString():String
		{
			return _source;
		}
	}

}