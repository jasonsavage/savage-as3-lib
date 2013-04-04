package com.savage.model 
{
	import com.savage.core.ApplicationFacade;
	import com.savage.model.vo.ConfigVO;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * The ConfigProxy class loads a configuration file called "swfconfig.xml" from the assets folder.
	 * @author Jason Savage
	 */
	public final class ConfigProxy extends URLLoaderProxy 
	{
		public static const NAME:String = "ConfigProxy";
		
		public static var DEFAULT_URL:String = "swfconfig.xml";
		public static var HYPERLINK_KEY:String = "HYPERLINKS";
		
		private var _onComplete:Function;
		
		/**
		 * Constructor
		 */
		public function ConfigProxy( data:String=null ) 
		{
			super(data);
			url = facade.resolveAssetsPath(DEFAULT_URL);
		}
		
		override public function getValue(key:String):Object 
		{
			if ( hasValue(key) )
			{
				var vo:ConfigVO = _data[key] as ConfigVO;
				if (vo.type != "")
					return vo.getDataTypeValue();
					
				return vo.value;
			}
				
			throw new ArgumentError("The key (" + key + ") was not found!");
		}
		
		override protected function proccessResult(content:String):void 
		{
			_data = new Dictionary();
			var xml:XML = new XML( content );
			for each(var ele:XML in xml.appSettings.elements())
			{
				var vo:ConfigVO = new ConfigVO(ele, this);
				setValue(vo.key, vo);
			}
			
			//auto register hyperlinks
			if ( hasValue(HYPERLINK_KEY) )
				facade.registerProxy( HyperLinkProxy.NAME, new HyperLinkProxy( getValue(HYPERLINK_KEY) as XMLList ) );
		}
		
		/**************************************
		 * Static
		 **************************************/
		
		public static function load(url:String = "", onComplete:Function = null, autoload:Boolean = false):ConfigProxy
		{
			var proxy:ConfigProxy = new ConfigProxy();
			proxy.url =  url + DEFAULT_URL;
			
			if (onComplete != null)
				proxy.addEventListener(Event.COMPLETE, onComplete);
				
			if (autoload)
				proxy.load();
				
			return proxy;
		}
	}

}