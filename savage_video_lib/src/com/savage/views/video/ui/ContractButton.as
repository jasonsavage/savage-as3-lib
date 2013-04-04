package com.savage.views.video.ui 
{
	import com.savage.graphics.complex.ContractIcon;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.views.IconButton;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ContractButton extends IconButton
	{
		/**
		 * Constructor
		 */
		public function ContractButton() 
		{
			super();
		}
		
		override protected function createIcon(color:uint):DrawnShape
		{
			return new ContractIcon(10, 10, color);
		}
	}

}