package com.savage.model.data 
{
	import com.savage.model.vo.DataProviderVO;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class NameTitleDataProvider extends DataProvider 
	{
		public static const TITLE_ABBREVS:Array = [
			"Mr.", "Mrs.", "Dr.", "MS.", "Miss"
		];
		
		/**
		 * Constructor
		 */
		public function NameTitleDataProvider() 
		{
			super();
			
			//populate provider
			var data:Vector.<DataProviderVO> = new Vector.<DataProviderVO>();
			for (var i:int = 0; i < TITLE_ABBREVS.length; i++)
			{
				var vo:DataProviderVO = new DataProviderVO();
				vo.label = TITLE_ABBREVS[i];
				vo.data = i.toString();
				data.push(vo);
			}
			
			//set source
			source = data;
		}
		
	}

}