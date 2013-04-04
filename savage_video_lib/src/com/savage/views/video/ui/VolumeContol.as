package com.savage.views.video.ui
{
	import com.savage.graphics.complex.SpeakerVolumeLines;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.LinearLayout;
	import com.savage.styles.ButtonStyle;
	import com.savage.styles.SpeakerVolumeBarsStyle;
	import com.savage.views.View;
	import com.savage.views.video.ui.SpeakerButton;
	import com.savage.views.video.ui.SpeakerVolumeBars;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class VolumeContol extends View 
	{
		private var _volume:Number = 1;
		
		//children
		private var _speakerButton:SpeakerButton
		private var _speakerVolBars:SpeakerVolumeBars;
		
		/**
		 * Constructor
		 */
		public function VolumeContol() 
		{
			super();
			layout = new LinearLayout(LinearLayout.HORIZONTAL, -4, true);
			layout.setSize(50,20);
			
			//set default styles
			setStyleDefinition({
				"SpeakerButton" : new ButtonStyle(),
				"SpeakerVolumeBars" : new SpeakerVolumeBarsStyle()
			});
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_speakerVolBars.value = _volume;
			_speakerButton.addEventListener(MouseEvent.CLICK, onSound_ClickHandler);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add button
			_speakerButton = new SpeakerButton();
			_speakerButton.layout.setSize(measureHeight(), measureHeight());
			_speakerButton.setStyleDefinition( getStyleValue("SpeakerButton") );
			addChild(_speakerButton);
			
			//add bars
			_speakerVolBars = new SpeakerVolumeBars();
			_speakerVolBars.setStyleDefinition( getStyleValue("SpeakerVolumeBars") );
			addChild(_speakerVolBars);
		}
		
		private function onSound_ClickHandler(e:MouseEvent):void 
		{
			_speakerVolBars.value += 0.2;
			_volume = _speakerVolBars.value;

			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get volume():Number { return _volume }
		public function set volume(value:Number):void
		{
			_volume = value;
			
			if(initialized)
				_speakerVolBars.value = _volume;
		}
		
	}

}