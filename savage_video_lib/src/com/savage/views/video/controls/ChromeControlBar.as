package com.savage.views.video.controls
{
	import com.savage.graphics.LineShape;
	import com.savage.graphics.styles.LineStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.AbsoluteLayout;
	import com.savage.layouts.LinearLayout;
	import com.savage.styles.ButtonStyle;
	import com.savage.styles.ProgressBarStyle;
	import com.savage.styles.SpeakerVolumeBarsStyle;
	import com.savage.styles.TextFieldStyle;
	import com.savage.views.View;
	import com.savage.views.video.VideoDisplayState;
	import com.savage.views.video.ui.FullScreenControl;
	import com.savage.views.video.ui.PlayPauseControl;
	import com.savage.views.video.ui.ProgressControl;
	import com.savage.views.video.ui.VolumeContol;
	
	import flash.display.CapsStyle;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.geom.Rectangle;
	
	/**
	 * The ChromeControlBar class ...
	 * @author jason.s
	 */
	public class ChromeControlBar extends ControlBarBase
	{
		//children
		private var _backgroundFrame:View;
		private var _foreground:View;
		
		private var _playPauseControl:PlayPauseControl;
		private var _progressControl:ProgressControl;
		private var _volumeControl:VolumeContol;
		private var _fullscreenControl:FullScreenControl;
		private var _defaultButtonStyle:ButtonStyle;
		
		/**
		 * Constructor
		 */
		public function ChromeControlBar()
		{
			super();
			layout = new AbsoluteLayout();
			layout.width = "100%";
			layout.height = 24;
			background = new SolidFillStyle(0xfbfbfb);
			
			_defaultButtonStyle = new ButtonStyle(0x000000, 0x929292, 0x000000);
		}
		
		override public function reset():void
		{
			super.reset();
			
			_playPauseControl.selectedIndex = 0;
			_progressControl.progress = 0;
			_volumeControl.volume = 1;
			_fullscreenControl.selectedIndex = 0;
		}
		
		override protected function addListeners():void
		{
			super.addListeners();
			
			_volumeControl.addEventListener(Event.CHANGE, onVolume_ChangeHandler);
			_playPauseControl.addEventListener(Event.CHANGE, onPlayPause_ChangeHandler);
			_progressControl.addEventListener(Event.CHANGE, onProgress_ChangeHandler);
			_fullscreenControl.addEventListener(Event.CHANGE, onFullScreen_ChangeHandler);
			addEventListener(Event.ENTER_FRAME, on_EnterFrameHandler);
		}
		
		override protected function removeListeners():void
		{
			super.removeListeners();
			
			_volumeControl.removeEventListener(Event.CHANGE, onVolume_ChangeHandler);
			_playPauseControl.removeEventListener(Event.CHANGE, onPlayPause_ChangeHandler);
			_fullscreenControl.removeEventListener(Event.CHANGE, onFullScreen_ChangeHandler);
			removeEventListener(Event.ENTER_FRAME, on_EnterFrameHandler);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			//add background frame
			_backgroundFrame = new View();
			_backgroundFrame.layout.setSize(measureWidth()-1, measureHeight()-1);
			_backgroundFrame.border = new LineStyle(1, 0xd6d6d6);
			_backgroundFrame.top = 0.5;
			_backgroundFrame.left = 0.5;
			addChild(_backgroundFrame);
			
				//add background rectangle
				var box:View = new View();
				box.layout.width = "100%";
				box.layout.height = "50%";
				box.bottom = 0;
				box.background = new SolidFillStyle(0xdadada);
				_backgroundFrame.addChild(box);
			
			//add foreground
			_foreground = new View();
			_foreground.layout = new LinearLayout(LinearLayout.HORIZONTAL, 0);
			_foreground.layout.setSize(measureWidth()-2, measureHeight()-2);
			_foreground.top = 1;
			_foreground.left = 1;
			addChild(_foreground);
			
				//add playpauseControl
				_playPauseControl = createPlayPauseControl();
				_foreground.addChild(_playPauseControl);
				
				//add divider
				var bar:LineShape = new LineShape(_foreground.measureHeight(), 1, 0xd6d6d6, 90);
				bar.lineStyle.caps = CapsStyle.SQUARE;
				bar.drawnHeight = _foreground.measureHeight();
				bar.drawnWidth = 1;
				_foreground.addChild(bar);
				
				//add progress control
				_progressControl = createProgressControl();
				_foreground.addChild(_progressControl);
				
				//add divider
				_foreground.addChild(bar.clone());
				
				//add volume control
				_volumeControl = createVolumeControl();
				_foreground.addChild(_volumeControl);
				
				//add divider
				_foreground.addChild(bar.clone());
				
				//add fullscreen control
				_fullscreenControl = createFullScreenControl();
				_foreground.addChild(_fullscreenControl);
		}
		
		override public function updateProperties():void
		{
			super.updateProperties();
			
			//update _progressControl to fill the rest of the space
			var used:Number = _playPauseControl.measureWidth() + _volumeControl.measureWidth() + _fullscreenControl.measureWidth() + 3
			_progressControl.layout.width = _foreground.measureWidth() - used;
			
		}
		
		private function createPlayPauseControl():PlayPauseControl
		{
			var _control:PlayPauseControl = new PlayPauseControl();
			_control.layout.width = _foreground.measureHeight();
			_control.layout.height = "100%";
			
			_control.setStyleValue("PlayButton", _defaultButtonStyle);
			_control.setStyleValue("PauseButton", _defaultButtonStyle);
			
			return _control;
		}
		
		private function createProgressControl():ProgressControl
		{
			var _control:ProgressControl = new ProgressControl();
			_control.layout.height = "100%";
			
			_control.setStyleValue("ProgressBar", new ProgressBarStyle(0x929292));
			_control.setStyleValue("TextField", new TextFieldStyle("Verdana",10,0,true));
			
			return _control;
		}
		
		private function createVolumeControl():VolumeContol
		{
			var _control:VolumeContol = new VolumeContol();
			_control.layout.height = "100%";
			
			_control.setStyleValue("SpeakerButton", _defaultButtonStyle);
			_control.setStyleValue("SpeakerVolumeBars", new SpeakerVolumeBarsStyle(0x000000, 0x929292));
			
			return _control;
		}
		
		private function createFullScreenControl():FullScreenControl
		{
			var _control:FullScreenControl = new FullScreenControl();
			_control.layout.width = _foreground.measureHeight();
			_control.layout.height = "100%";
			
			_control.setStyleValue("ExpandButton", _defaultButtonStyle);
			_control.setStyleValue("ContractButton", _defaultButtonStyle);
			
			return _control;
		}
		
		/**************************************
		 * Handlers
		 **************************************/
		
		private function onPlayPause_ChangeHandler(event:Event):void 
		{
			if (_playPauseControl.selectedIndex == 1)
				source.playVideo();
			
			if (_playPauseControl.selectedIndex == 0)
				source.pauseVideo();
		}
		
		protected function onProgress_ChangeHandler(event:Event):void
		{
			var seek:Number = _progressControl.progress * source.totalTime;
			source.seekVideo( seek );
		}

		private function onVolume_ChangeHandler(event:Event):void 
		{
			source.volume = _volumeControl.volume;
		}
	
		private function onFullScreen_ChangeHandler(event:Event):void
		{
			if (_fullscreenControl.selectedIndex == 1)
			{
				//go to fullscreen
				stage.fullScreenSourceRect = new Rectangle(source.x, source.y, source.measureWidth(), source.measureHeight());
				stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.addEventListener(Event.FULLSCREEN, on_FullScreenHandler);
			}
			
			if (_fullscreenControl.selectedIndex == 0)
			{
				//return to normal 
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function on_FullScreenHandler(event:FullScreenEvent):void
		{
			stage.removeEventListener(Event.FULLSCREEN, on_FullScreenHandler);
			_fullscreenControl.selectedIndex = 0;
		}
		
		private function on_EnterFrameHandler(event:Event):void 
		{
			if (!source) return;
			
			_progressControl.duration = source.totalTime;
			_progressControl.progress = source.playheadTime;
			
			if (source.state == VideoDisplayState.PLAYING || source.state == VideoDisplayState.BUFFERING)
				_playPauseControl.selectedIndex = 1;
			else
				_playPauseControl.selectedIndex = 0;
		}
		
	}
}