package com.savage.model.data 
{
	import com.savage.model.vo.DataProviderVO;
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class CANProvincesDataProvider extends DataProvider 
	{
		public static const NAMES:Array = [
				"Ontario",
				"Quebec",
				"British Columbia",
				"Alberta",
				"Manitoba",
				"Saskatchewan",
				"Nova Scotia",
				"New Brunswick",
				"Newfoundland & Labr.",
				"Prince Edward Island",
				"Northwest Territories",
				"Yukon",
				"Nunavut"
		];
			
		public static const ABBREVS:Array = [
				"ON",
				"QC",
				"BC",
				"AB",
				"MB",
				"SK",
				"NS",
				"NB",
				"NL",
				"PE",
				"NT",
				"YK",
				"NU"
		];
		
		/**
		 * Constructor
		 */
		public function CANProvincesDataProvider(labelsArray:Array = null, datasArray:Array = null) 
		{
			super();
			
			labelsArray = (labelsArray)? labelsArray : NAMES;
			source = DataProvider.merge(labelsArray, datasArray);
		}
		
		public static function getNamesNames():CANProvincesDataProvider
		{
			return new CANProvincesDataProvider(NAMES, NAMES);
		}
		
		public static function getAbbrevsAbbrevs():CANProvincesDataProvider
		{
			return new CANProvincesDataProvider(ABBREVS, ABBREVS);
		}
		
		public static function getNamesAbbrevs():CANProvincesDataProvider
		{
			return new CANProvincesDataProvider(NAMES, ABBREVS);
		}
		
		public static function getAbbrevsNames():CANProvincesDataProvider
		{
			return new CANProvincesDataProvider(ABBREVS, NAMES);
		}
		
		
	}

}