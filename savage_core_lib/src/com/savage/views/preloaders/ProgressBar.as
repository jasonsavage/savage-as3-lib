package com.savage.views.preloaders 
{
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.styles.GradientFillStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.styles.ProgressBarStyle;
	import com.savage.utils.MathUtil;
	import com.savage.views.View;
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class ProgressBar extends View
	{
		private var _value:Number = 1;
		private var _bar:RectangleShape;
		
		/**
		 * Constructor
		 */
		public function ProgressBar() 
		{
			super();
			//draw background
			layout.setSize(150,6);
			background = new GradientFillStyle(GradientType.LINEAR, [0xA89BA8, 0xC6BDC6], [1, 1]);
			
			//set default style
			setStyleDefinition( new ProgressBarStyle() );
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//create bar
			_bar = new RectangleShape(measureWidth(), measureHeight(), getStyleValue("barColor") as uint);
			addChild(_bar);
		}
		
		override public function updateProperties():void
		{
			super.updateProperties();
			
			_bar.drawnWidth = measureWidth();
			_bar.drawnHeight = measureHeight();
			_bar.scaleX = _value;
		}

		/**************************************
		 * Accessors
		 **************************************/
		
		public function get value():Number { return _value; }
		public function set value(value:Number):void
		{
			_value = MathUtil.limit(value, 0, 1);
			
			if(initialized)
				_bar.scaleX = _value;
		}
	}

}