package com.savage.views.video.ui 
{
	import com.savage.styles.ButtonStyle;
	import com.savage.views.ButtonStack;
	import com.savage.views.StackView;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class FullScreenControl extends ButtonStack
	{
		
		//children
		private var _expandBtn:ExpandButton;
		private var _contractBtn:ContractButton;
		
		/**
		 * Constructor
		 */
		public function FullScreenControl() 
		{
			super();
			
			//set default styles
			setStyleDefinition({
				"ExpandButton" : new ButtonStyle(),
				"ContractButton" : new ButtonStyle()
			});
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			_expandBtn = new ExpandButton();
			_expandBtn.setStyleDefinition( getStyleValue("ExpandButton") );
			addChild(_expandBtn);
			
			_contractBtn = new ContractButton();
			_contractBtn.setStyleDefinition( getStyleValue("ContractButton") );
			addChild(_contractBtn);
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get expandButton():ExpandButton { return _expandBtn; }
		public function get contractButton():ContractButton { return _contractBtn; }
	}

}