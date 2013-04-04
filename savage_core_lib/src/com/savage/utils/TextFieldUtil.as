package com.savage.utils 
{
	import com.savage.business.TextLoader;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author 
	 */
	public class TextFieldUtil
	{
		
		public static function listEmbeddedFontNames():void
		{
			trace("//embeded fonts-------------"); 
			var embedded:Array = Font.enumerateFonts();
			for each(var font:Font in embedded)
				trace("font: ", font.fontName); 
			trace("//--------------------------"); 
		}
		
		/**
		 * Creates a textField based n the specified parameters.
		 * @param	text
		 * @param	width
		 * @param	height
		 * @param	format
		 * @param	autoSize
		 * @param	embedFonts
		 * @param	selecatable
		 * @return
		 */
		public static function createTextField(text:String="", width:Object=null, height:Object=null, format:TextFormat=null, autoSize:String="none", embedFonts:Boolean=true, selecatable:Boolean=false):TextField
		{
			var field:TextField = new TextField();
			var format:TextFormat = format || createTextFormat();
			
			field.defaultTextFormat = format;
			field.autoSize = autoSize;
			field.embedFonts = embedFonts;
			field.selectable = selecatable;
			field.text = text;
			
			if (height && height is Number)
				field.height = height as Number;
				
			if (width && width is Number)
				field.width = width as Number;
				
			return field;
		}
		
		/**
		 * Creates a TextFormat for a textfield based on the specified parameters.
		 * @param	fontFamily
		 * @param	size
		 * @param	color
		 * @param	bold
		 * @param	italic
		 * @param	align
		 * @param	leading
		 * @return
		 */
		public static function createTextFormat(fontFamily:String="Arial", size:Number=12, color:uint=0x000000, bold:Boolean=false, italic:Boolean=false, align:String="left", leading:Object=null):TextFormat
		{
			var format:TextFormat = new TextFormat(fontFamily, size, color, bold, italic, null, null, null, align, null, null, null, leading);
			return format;
		}
		
		private static var _loaders:Vector.<TextLoader>;
		
		/**
		 * Auto loads the text from a specified source into a textfield.
		 * @param	field
		 * @param	source
		 */
		public static function loadTextFromSource(field:TextField, source:String):void 
		{
			if (!_loaders)
				_loaders = new Vector.<TextLoader>;
				
			var l:TextLoader = new TextLoader(field, new URLRequest(source));
			l.addEventListener(Event.COMPLETE, onText_LoadComplete);
			
			_loaders.push(l);
		}
		
		private static function onText_LoadComplete(event:Event):void 
		{
			event.target.removeEventListener(Event.COMPLETE, onText_LoadComplete);
			var i:int = _loaders.indexOf(event.target);
			_loaders.splice(i, 1);
		}
		
	}
	
	

}

