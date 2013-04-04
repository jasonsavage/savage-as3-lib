package com.savage.air.model
{
	import com.savage.model.ApplicationProxy;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	
	/**
	 * The LogFileProxy class ...
	 * @author jason.s
	 */
	public class LogFileProxy extends ApplicationProxy
	{
		private var _lineNumber:int = -1;
		private var _file:File;
		
		/**
		 * Constructor
		 */
		public function LogFileProxy(file:File)
		{
			super();
			_file = file;
			_file.addEventListener(IOErrorEvent.IO_ERROR, onFile_ErrorHandler);
			_file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onFile_ErrorHandler);
			
			//clear data in file
			clear();
		}
		
		public function clear():void
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(_file, FileMode.WRITE);
			fileStream.writeUTFBytes("");
			fileStream.close();
		}
		
		public function log(msg:String):void
		{
			try
			{
				_lineNumber++;
				
				var fileStream:FileStream = new FileStream();
				fileStream.open(_file, FileMode.APPEND);
				fileStream.writeUTFBytes(_lineNumber + " : " + msg + "\n");
				fileStream.close();
			}
			catch(e:Error)
			{
				trace("Error occured while appending to file.");
			}
		}
		
		/**
		 * Handles the Error event that is dispatched from File.	
		 */
		protected function onFile_ErrorHandler(event:Event):void
		{
			trace(event.type);
		}
	}
}