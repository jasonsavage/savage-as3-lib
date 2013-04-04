package com.savage.views.video.ui 
{
	import com.savage.graphics.RectangleShape;
	import com.savage.graphics.complex.SpeakerVolumeLines;
	import com.savage.layouts.CenterLayout;
	import com.savage.layouts.FrameLayout;
	import com.savage.styles.SpeakerVolumeBarsStyle;
	import com.savage.utils.LayoutUtil;
	import com.savage.utils.MathUtil;
	import com.savage.views.View;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class SpeakerVolumeBars extends View
	{
		private var _value:Number = 1;
		
		//children
		private var _barsBg:SpeakerVolumeLines;
		private var _barsFg:SpeakerVolumeLines;
		private var _barMask:RectangleShape;
		
		/**
		 * Constructor
		 */
		public function SpeakerVolumeBars() 
		{
			super();
			layout = new CenterLayout(30,20, true, false);
			
			//set default styles
			setStyleDefinition(new SpeakerVolumeBarsStyle());
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//background lines
			_barsBg = new SpeakerVolumeLines(10, 1, getStyleValue("backgroundLineColor") as uint);
			addChild(_barsBg);
			
			//foreground lines
			_barsFg = new SpeakerVolumeLines(10, 1, getStyleValue("lineColor") as uint);
			addChild(_barsFg);
			
			//mask
			_barMask = new RectangleShape(_barsFg.measureWidth(), measureHeight());
			_barMask.scaleX = _value;
			addChild(_barMask);
			
			_barsFg.mask = _barMask;
		}
		
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get value():Number { return _value; }
		public function set value(value:Number):void
		{
			_value = MathUtil.limitWrap(value, 0, 1);
			
			if(initialized)
				_barMask.scaleX = _value;
		}
	}

}