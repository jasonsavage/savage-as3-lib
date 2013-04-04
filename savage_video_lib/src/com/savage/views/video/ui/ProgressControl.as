package com.savage.views.video.ui
{
	import com.savage.layouts.CenterLayout;
	import com.savage.layouts.LinearLayout;
	import com.savage.styles.ProgressBarStyle;
	import com.savage.styles.TextFieldStyle;
	import com.savage.utils.LayoutUtil;
	import com.savage.utils.MathUtil;
	import com.savage.utils.NumberUtil;
	import com.savage.views.View;
	import com.savage.views.preloaders.ProgressBar;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	/**
	 * The ProgressControl class ...
	 * @author jason.s
	 */
	public class ProgressControl extends View
	{
		private var _duration:Number = 1;
		private var _progress:Number = 0;
		
		//children
		private var _progressField:TextField;
		private var _durationField:TextField;
		private var _bar:ProgressBar;
		
		/**
		 * Constructor
		 */
		public function ProgressControl()
		{
			super();
			layout = new LinearLayout(LinearLayout.HORIZONTAL, 10, true);
			layout.setPadding(0, 10, 0, 10);
			
			//default styles
			setStyleDefinition({
				"TextField" : new TextFieldStyle(),
				"ProgressBar" : new ProgressBarStyle()
			});
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
			//add progress field
			_progressField = createTextField();
			addChild(_progressField);
			
			//add bar
			_bar = new ProgressBar();
			_bar.setStyleDefinition( getStyleValue("ProgressBar") );
			addChild(_bar);
			
			//add duration field
			_durationField = createTextField();
			addChild(_durationField);
			
		}
		
		private function updateProgress():void
		{
			_progressField.text = NumberUtil.timecodeMS(_progress);
			_bar.value = _progress/_duration;
		}
		
		override public function updateProperties():void
		{
			super.updateProperties();
			
			//update values
			updateProgress();
			
			//measure layout
			var used:Number = LayoutUtil.measureObjectWidth(_progressField) + LayoutUtil.measureObjectWidth(_durationField) + 40;
			_bar.layout.width = measureWidth() - used;
		}

		protected function createTextField():TextField
		{
			var field:TextField = new TextField();
			field.autoSize = TextFieldAutoSize.LEFT;
			field.selectable = false;
			field.text = "00:00";
			
			//set style
			var style:TextFieldStyle = getStyleValue("TextField") as TextFieldStyle;
			field.defaultTextFormat = style.getTextFormat();
			field.embedFonts = style.embed;
			
			return field;
		}	
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void
		{
			_duration = value;
			
			if(initialized)
			{
				_durationField.text = NumberUtil.timecodeMS(_duration);
				updateDisplayList();
			}
		}
		
		
		public function get progress():Number { return _progress; }
		public function set progress(value:Number):void
		{
			_progress = MathUtil.limit(value, 0, _duration);
			
			if(initialized)
				updateProgress();
		}
		
		
	}
}