package com.savage.model 
{
	import com.savage.model.vo.HyperLinkVO;
	
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public final class HyperLinkProxy extends ApplicationProxy 
	{
		public static const NAME:String = "HyperLinkProxy";
		
		/**
		 * Constructor
		 */
		public function HyperLinkProxy( xml:XMLList ) 
		{
			super( new Object() );
			
			for each(var ele:XML in xml.elements())
			{
				var vo:HyperLinkVO = new HyperLinkVO(ele, this);
				setValue(vo.id, vo);
			}
		}
		
	}

}