package com.savage.views.video.ui 
{
	import com.savage.graphics.LineShape;
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.complex.SpeakerShape;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.CenterLayout;
	import com.savage.styles.PushButtonStyle;
	import com.savage.views.PushButtonView;
	import com.savage.views.View;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class MuteButton extends PushButtonView 
	{
		/**
		 * Constructor
		 */
		public function MuteButton() 
		{
			super();
			layout.width = 20;
			layout.height = 20;
			
			//set defualt style
			setStyleDefinition( new PushButtonStyle() );
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
			//add up state
			addChild( createUpStateView() );
			
			//add over state
			addChild( createOverStateView() );
			
			//add down state
			addChild( createDownStateView() );
			
			//add selected state
			addChild( createSelectedStateView() );
		}
		
		protected function createUpStateView():View 
		{
			return createView( getStyleValue("upColor") as uint);
		}
		protected function createOverStateView():View 
		{
			return createView( getStyleValue("overColor") as uint );
		}
		protected function createDownStateView():View 
		{
			return createView( getStyleValue("downColor") as uint );
		}
		protected function createSelectedStateView():View 
		{
			return createView( getStyleValue("selectedColor") as uint, true);
		}
		
		protected function createView(color:uint, slash:Boolean=false):View
		{
			var view:View = new View();
			view.layout = new CenterLayout("100%","100%");
			view.background = new SolidFillStyle(0,0);
			
			var w:Number = measureWidth();
			var h:Number = measureHeight();
			
			view.addChild( new SpeakerShape(w * 0.25, h * 0.5, color) );
			
			if (slash)
				view.addChild( new LineShape(h * 0.5, w * 0.1, color, 45) );
			
			return view;
		}
		
	}

}