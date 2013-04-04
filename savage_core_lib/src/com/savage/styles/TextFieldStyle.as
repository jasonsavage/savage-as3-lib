package com.savage.styles
{
	import flash.text.TextFormat;
	
	/**
	 * The TextFieldStyle class ...
	 * @author jason.s
	 */
	public class TextFieldStyle
	{
		public var font:String;
		public var size:Number;
		public var color:uint; 
		public var bold:Boolean; 
		public var italic:Boolean; 
		public var embed:Boolean; 
		
		/**
		 * Constructor
		 */
		public function TextFieldStyle(font:String="Arial", size:Number=12, color:uint=0, bold:Boolean=false, italic:Boolean=false, embed:Boolean=true)
		{
			this.font = font; 
			this.size = size;
			this.color = color;
			this.bold = bold;
			this.italic = italic;
		}
		
		public function getTextFormat():TextFormat
		{
			return new TextFormat(font, size, color, bold, italic);
		}
	}
}