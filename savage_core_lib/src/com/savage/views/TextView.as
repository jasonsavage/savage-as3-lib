package com.savage.views
{
	import com.savage.layouts.FrameLayout;
	import com.savage.views.View;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class TextView extends View
	{
		/**************************************
		 * Properties
		 **************************************/
		
		private var _fontFamily:String 	= "Arial";
		private var _color:uint 	= 0x000000;
		private var _fontSize:int 	= 12;
		private var _bold:Boolean 	= false;
		private var _italic:Boolean = false;
		private var _text:String 	= "";
		private var _htmlText:String = "";
		private var _selectable:Boolean = true;
		private var _align:String	= TextFormatAlign.LEFT;
		private var _embedFonts:Boolean = true;
		private var _leading:Object;
		
		//children
		private var _innerField:TextField;
		
		
		
		/**
		 * Constructor
		 */
		public function TextView() 
		{
			super();
			layout = new FrameLayout();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//create textfield
			_innerField = new TextField();
			addChild(_innerField);
		}
		
		override public function updateProperties():void
		{
			super.updateProperties();
			
			//setup textfield to match view settings
			
			if ( layout.width )
			{
				//resize inner field to match width settings
				_innerField.width = measureWidth() - layout.paddingLeft - layout.paddingRight;
				_innerField.wordWrap = true;
				layout.height = null;
			}
			else if ( layout.height )
			{
				//resize inner field to match height settings
				_innerField.height = measureHeight() - layout.paddingTop - layout.paddingBottom;
				layout.width = null;
			}
			
			//update text format
			_innerField.defaultTextFormat = new TextFormat(_fontFamily, _fontSize, _color, _bold, _italic, null, null, null, _align, null, null, null, _leading);
			_innerField.selectable = _selectable;
			_innerField.multiline = true;
			
			//embed fonts
			_innerField.embedFonts = _embedFonts;
			
			//set text
			if(_text != "")
				_innerField.text = _text;
			else if(_htmlText != "")
				_innerField.htmlText = _htmlText;
		}
		
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get textField():TextField { return _innerField; }
		
		public function get text():String { return _text; }
		public function set text(value:String):void
		{
			_text = value;
			_htmlText = "";
			invalidateProperties();
		}
		
		public function get htmlText():String { return _htmlText; }
		public function set htmlText(value:String):void
		{
			_htmlText = value;
			_text = "";
			invalidateProperties();
		}
		
		public function get selectable():Boolean { return _selectable; }
		public function set selectable(value:Boolean):void
		{
			_selectable = value;
			invalidateProperties();
		}
		
		public function get fontFamily():String { return _fontFamily; }
		public function set fontFamily(value:String):void
		{
			_fontFamily = value;
			invalidateProperties();
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			_color = value;
			invalidateProperties();
		}

		public function get fontSize():int { return _fontSize; }
		public function set fontSize(value:int):void
		{
			_fontSize = value;
			invalidateProperties();
		}
		
		public function get bold():Boolean { return _bold; }
		public function set bold(value:Boolean):void
		{
			_bold = value;
			invalidateProperties();
		}
		
		public function get italic():Boolean { return _italic; }
		public function set italic(value:Boolean):void
		{
			_italic = value;
			invalidateProperties();
		}
		
		public function get align():String { return _align; }
		public function set align(value:String):void
		{
			_align = value;
			invalidateProperties();
		}
		
		public function get embedFonts():Boolean { return _embedFonts; }
		public function set embedFonts(value:Boolean):void
		{
			_embedFonts = value;
			invalidateProperties();
		}
		
		public function get leading():Object { return _leading; }
		public function set leading(value:Object):void
		{
			_leading = value;
			invalidateProperties();
		}
		
	}

}