package com.savage.views
{
	import com.savage.graphics.complex.ExpandIcon;
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.CenterLayout;
	import com.savage.views.ButtonBase;
	import com.savage.views.View;
	
	/**
	 * The IconButton class ...
	 * @author jason.s
	 */
	public class IconButton extends ButtonBase
	{
		/**
		 * Constructor
		 */
		public function IconButton()
		{
			super(this);
			layout.setSize(20,20);
		}
		
		override protected function createUpStateView():View 
		{
			return createView( getStyleValue("upColor") as uint );
		}
		
		override protected function createOverStateView():View 
		{
			return createView( getStyleValue("overColor") as uint );
		}
		
		override protected function createDownStateView():View 
		{
			return createView( getStyleValue("downColor") as uint );
		}
		
		protected function createView(color:uint):View
		{
			var view:View = new View();
			view.layout = new CenterLayout("100%","100%");
			view.background = new SolidFillStyle(0,0);
			
			view.addChild( createIcon(color) );
			return view;
		}
		
		protected function createIcon(color:uint):DrawnShape
		{
			return new DrawnShape();
		}
		
	}
}