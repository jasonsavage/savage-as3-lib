package com.savage.model.data 
{
	import com.savage.model.vo.DataProviderVO;
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class USStatesDataProvider extends DataProvider 
	{
		public static const NAMES:Array = [
				"Alabama",
				"Alaska",
				"Arizona",
				"Arkansas",
				"California",
				"Colorado",
				"Connecticut",
				"District of Columbia",
				"Delaware",
				"Florida",
				"Georgia",
				"Hawaii",
				"Idaho", 
				"Illinois",
				"Indiana",
				"Iowa",
				"Kansas",
				"Kentucky",
				"Louisiana",
				"Maine",
				"Maryland",
				"Massachusetts",
				"Michigan",
				"Minnesota",
				"Mississippi",
				"Missouri",
				"Montana",
				"Nebraska",
				"Nevada",
				"New Hampshire",
				"New Jersey",
				"New Mexico", 
				"New York",
				"North Carolina",
				"North Dakota",
				"Ohio",
				"Oklahoma",
				"Oregon",
				"Pennsylvania",
				"Rhode Island",
				"South Carolina",
				"South Dakota", 
				"Tennessee", 
				"Texas",
				"Utah", 
				"Vermont", 
				"Virginia", 
				"Washington",
				"West Virginia",
				"Wisconsin",
				"Wyoming"
		];
			
		public static const ABBREVS:Array = [
				"AL",
				"AK",
				"AZ",
				"AR",
				"CA",
				"CO",
				"CT",
				"DC",
				"DE",
				"FL",
				"GA",
				"HI",
				"ID",
				"IL",
				"IN",
				"IA",
				"KS",
				"KY",
				"LA",
				"ME",
				"MD",
				"MA",
				"MI",
				"MN",
				"MS",
				"MO",
				"MT",
				"NE",
				"NV",
				"NH",
				"NJ",
				"NM",
				"NY",
				"NC",
				"ND",
				"OH",
				"OK",
				"OR",
				"PA",
				"RI",
				"SC",
				"SD",
				"TN",
				"TX",
				"UT",
				"VT",
				"VA",
				"WA",
				"WV",
				"WI",
				"WY"
		];
		
		/**
		 * Constructor
		 */
		public function USStatesDataProvider(labelsArray:Array = null, datasArray:Array = null) 
		{
			super();
			
			labelsArray = (labelsArray)? labelsArray : NAMES;
			source = DataProvider.merge(labelsArray, datasArray);
		}
		
		public static function getNamesNames():USStatesDataProvider
		{
			return new USStatesDataProvider(NAMES, NAMES);
		}
		
		public static function getAbbrevsAbbrevs():USStatesDataProvider
		{
			return new USStatesDataProvider(ABBREVS, ABBREVS);
		}
		
		public static function getNamesAbbrevs():USStatesDataProvider
		{
			return new USStatesDataProvider(NAMES, ABBREVS);
		}
		
		public static function getAbbrevsNames():USStatesDataProvider
		{
			return new USStatesDataProvider(ABBREVS, NAMES);
		}
		
	}

}