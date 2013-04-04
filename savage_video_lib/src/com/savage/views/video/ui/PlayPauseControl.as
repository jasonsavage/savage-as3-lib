package com.savage.views.video.ui 
{
	import com.savage.styles.ButtonStyle;
	import com.savage.views.ButtonStack;
	import com.savage.views.StackView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PlayPauseControl extends ButtonStack
	{
		//children
		private var _playBtn:PlayButton;
		private var _pauseBtn:PauseButton;
		
		/**
		 * Constructor
		 */
		public function PlayPauseControl() 
		{
			super();
			
			//set default styles
			setStyleDefinition({
				"PlayButton" : new ButtonStyle(),
				"PauseButton" : new ButtonStyle()
			});
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			//add play
			_playBtn = new PlayButton();
			_playBtn.setStyleDefinition( getStyleValue("PlayButton") );
			addChild(_playBtn);
			
			//add pause
			_pauseBtn = new PauseButton();
			_pauseBtn.setStyleDefinition( getStyleValue("PauseButton") );
			addChild(_pauseBtn);
		}
		
		/**************************************
		 * Accessors
		 **************************************/

		public function get playButton():PlayButton { return _playBtn; }
		public function get pauseButton():PauseButton { return _pauseBtn; }
	}

}