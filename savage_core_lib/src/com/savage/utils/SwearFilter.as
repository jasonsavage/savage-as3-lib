package com.savage.utils
{
	/**
	 * ...
	 * @author Xtian Mayer
	 */
	public class SwearFilter
	{
		private var _regExp:RegExp;
		private var _onBlockWord:Function;
		
		private var _symbolMap:Array = [
			["a","@"],
			["i","!"],
			["i","|"],
			["s","5"],
			["s","$"],
			["o","0"],
			["c","<"]
		];
		
		private var _dirtyWordsPart:Array = [
			"ass","azz","ho","hoe","vag","jap","muf"
		];
		
		private var _dirtyWords:Array = [
			//a
			"anal",
			//b
			"bitch","blowjob","boner","ballbag","balbag",
			//c
			"cunt","cock","clit","choad","coochie","coon","cooter","cum",
			//d
			"dildo","dick","dago","damn","douche","dooch","dookie","dumb","dyke",
			//e
			"erection",
			//f
			"fuck","fucker","fuk","fuc","fag","faggot","faggit","fellatio","feltch","flamer","fudgepacker","fisting",
			//g
			"gay","god","gooch","gook","gringo","guido","genitalia",
			//h
			"homosexual","homo","handjob","hard on","hardon","heeb","hoe","honkey",
			//i
			"idiot",
			//j
			"jap","jerk","jizz","jungle bunny","junglebunny",
			//k
			"kike","kooch","kootch","kraut","kunt","kyke",
			//l
			"lameass","lesbian","lesbo","lezzie",
			//m
			"moron","mothafucka","munging","marijuana","milf",
			//n
			"nigga","nigger","negro","nigaboo","niggers","niglet","nut sack","nutsack", 
			//o
			//p
			"pussy","penis","paki","panooch","pecker","piss","polesmoker","pollock","poon","porch monkey",
			"porchmonkey","prick","punanny","punta","pussies","puto","poop","porn",
			//q
			"queef","queer",
			//r
			"renob","rimjob","ruski",
			//s
			"shit","slut","sex","sand nigger","sandnigger","schlong","scrote","shiz","skank","skeet","smeg",
			"spic","spick","splooge","suckass",
			//t
			"tard","testicle","tits","titty","titties","twat",
			//u
			//v
			"vagina","vajj","va-j-j","va jj","va j j","vajayjay","vjayjay",
			//w
			"whore","wank","wackoff","wetback","wop","wackit"
			//x
			//y
			//z
		];
			
		public function SwearFilter() 
		{
			_regExp = constructRegex();
		}
		
		public function filter(s:String):String
		{
			var words:Array = s.split(" ");
			for(var i:int = 0; i < words.length; i++)
			{
				words[i] = decontaminate( words[i] );
			}
			
			return words.join(" ");
		}
		
		private function decontaminate(value:String):String
		{
			//replace symbols in word
			var tmp:String = replaceSymbols(value);
			
			//test word
			var result:Boolean = _regExp.test(tmp);
			
			if(result && _onBlockWord != null)
				_onBlockWord(value, tmp);
			
			//return word, ***word, or ****
			return result ? maskValue(value) : value;
		}
		
		private function replaceSymbols(value:String):String
		{
			var retVal:String = value.replace(new RegExp("[-_\*]", "g"), "");
			
			var i:int = _symbolMap.length;
			while(i--)
				retVal = retVal.replace(_symbolMap[i][1], _symbolMap[i][0]);
			
			return retVal;
		}
		
		private function constructRegex():RegExp
		{
			var filterWords:String = "";
			var fLength:uint = _dirtyWords.length;
			
			for (var i:uint = 0; i < fLength; i++)
			{
				var fword:String = _dirtyWords[i];
				filterWords += (i < fLength-1) ? fword + "|" : fword;
			}
			
			return new RegExp("("+ filterWords +")","i");
			
		}
		
		private function maskValue(value:String):String
		{
			return value.replace(/[\w\d]/g,"*");			
		}
		
		
		public function get onBlockWord():Function { return _onBlockWord; }
		public function set onBlockWord(value:Function):void
		{
			_onBlockWord = value;
		}
		
		
	}

}