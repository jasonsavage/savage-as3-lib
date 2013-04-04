package com.savage.views.video 
{
	import com.savage.events.VideoDisplayEvent;
	import com.savage.graphics.styles.FillStyle;
	import com.savage.graphics.styles.SolidFillStyle;
	import com.savage.layouts.CenterLayout;
	import com.savage.views.View;
	
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class VideoDisplay extends View
	{
		private var _autoPlay:Boolean = true;
		private var _source:String;
		private var _state:String;
		private var _totalTime:Number;
		private var _bufferTime:Number = 5;
		
		private var _connection:NetConnection;
		private var _stream:NetStream;
		
		//internal flags
		private var _connected:Boolean;
		private var _streamInUse:Boolean;
		private var _sourceChanged:Boolean;
		private var _playOnConnected:Boolean;
		private var _ending:Boolean;
		private var _startEventDispatched:Boolean;
		
		private var _autoSizeLayout:Boolean;
		
		//children
		private var _innerVideo:Video;
		
		/**
		 * Constructor
		 */
		public function VideoDisplay() 
		{
			super();
			layout = new CenterLayout(320, 240);
			background = new SolidFillStyle();
		}
		
		public function playVideo(restartStream:Boolean=false):void
		{
			if (!_connected)
			{
				_playOnConnected = true;
				connect();
			}
			else
			{
				//if no stream then create
				if (!_stream)
				{
					_stream = new NetStream(_connection);
					_stream.addEventListener(NetStatusEvent.NET_STATUS, on_NetStatusHandler);
					_stream.bufferTime = _bufferTime;
					_stream.client = this;
					
					_innerVideo.attachNetStream(_stream);
				}
				
				if (_sourceChanged)
				{
					//if stream is in use clear out old stream
					if (_streamInUse)
					{
						_stream.close();
						_innerVideo.clear();
						_streamInUse = false;
					}
					
					_streamInUse = true;
					_sourceChanged = false;
					_startEventDispatched = false;	
					
					_stream.play( _source );
				}
				else
				{
					if (restartStream)
						seekVideo(0);

					_stream.resume();
					state = VideoDisplayState.PLAYING;
				}
			}
		}
		
		public function pauseVideo():void
		{
			if (!_stream) return;
			
			_stream.pause();
			state = VideoDisplayState.PAUSED;
		}
		
		public function seekVideo(offset:Number):void
		{
			if (!_stream) return;
			
			_stream.seek(offset);
		}
		
		/**
		 * Ends video stream and clears out display.
		 */
		public function stopVideo():void
		{
			_stream.close();
			_streamInUse = false;
			
			_innerVideo.clear();
			_connection.close();
			_connected = false;
		}
		
		public function setVideoSize(width:Number, height:Number):void
		{
			_innerVideo.width = width;
			_innerVideo.height = height;
		}
		
		/**************************************
		 * Override /  Private
		 **************************************/
		
		private function connect():void
		{
			if (state == VideoDisplayState.CONNECTING) return;
			
			state = VideoDisplayState.CONNECTING;
			
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, on_NetStatusHandler);
			_connection.client = this;
			_connection.connect(null);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if(_autoPlay && _source)
			{
				playVideo();
			}
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			_innerVideo = new Video(measureWidth(), measureHeight());
			_innerVideo.smoothing = true;
            addChild(_innerVideo);
		}
		
		private function updateVideoWidth(data:Object):void
		{
			if (data.width && data.width > 0)
			{
				_innerVideo.width = data.width;
			}
			else if (_innerVideo.videoWidth > 0)
			{
				_innerVideo.width = _innerVideo.videoWidth;
			}
		}
		
		private function updateVideoHeight(data:Object):void
		{
			if (data.height && data.height > 0)
			{
				_innerVideo.height = data.height;
			}
			else if (_innerVideo.videoHeight > 0)
			{
				_innerVideo.height = _innerVideo.videoHeight;
			}
		}
		
		
		/**************************************
		 * Handlers
		 **************************************/
		
		/**
		 * Handles the NetStatus Event that is dispatched from .
		 * @param event
		 */
		private function on_NetStatusHandler(event:NetStatusEvent):void
		{
			//trace(event.info.code);
			
			switch (event.info.code) 
			{
                case "NetConnection.Connect.Success":
					_connected = true;
					state = VideoDisplayState.CONNECTED;
					
					if (_playOnConnected)
					{
						_playOnConnected = false;
						playVideo();
					}
					
				break;
				
				case "NetConnection.Connect.Closed":
					_connected = false;
					state = VideoDisplayState.DISCONNECTED;
				break;
				
				case "NetStream.Play.Start":
					state = VideoDisplayState.BUFFERING;
				break;
				
				case "NetStream.Buffer.Full":
					
					if (playheadTime < 1)
					{
						state = VideoDisplayState.PLAYING;
						_ending = false;
							
						if (!_startEventDispatched)
						{
							_startEventDispatched = true;
							dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.START));
						}
					}
				break;
				
				case "NetStream.Buffer.Flush":
					_ending = true;
				break;
				
				case "NetStream.Buffer.Empty":
					
					if (_ending || playheadTime > totalTime-1)
					{
						_ending = false;
						_startEventDispatched = false;
						state = VideoDisplayState.CONNECTED;
						dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.COMPLETE));
					}
				break;
				
                case "NetStream.Play.StreamNotFound":
					state = VideoDisplayState.CONNECTED; //back to connected
					_streamInUse = false;
					dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.ERROR));
                break;
            }
		}
		
		public function onCuePoint(data:Object):void
		{
			dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.CUE_POINT, false, false, data));
		}
		
		public function onMetaData(data:Object):void
		{
			updateVideoWidth(data);
			updateVideoHeight(data);
			
			if (_autoSizeLayout)
			{
				layout.width = _innerVideo.width;
				layout.height = _innerVideo.height;
			}
			
			if(data.duration)
				_totalTime = data.duration;
				
			invalidateDisplayList();
			
			dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.META_DATA, false, false, data));
		}
		
		public function onXMPData(data:Object):void
		{
			dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.XMP_DATA, false, false, data));
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get playheadTime():Number 
		{ 
			if (!_stream)
				return 0;
				
			if (_stream.time > _totalTime)
				return _totalTime;
				
			return _stream.time;
		}
		
		public function get totalTime():Number 
		{ 
			return _totalTime ? _totalTime : 0; 
		}
		 
		public function get source():String { return _source; }
		public function set source(value:String):void
		{
			if (value == "" || value == _source) return;
			
			_source = value;
			_sourceChanged = true;

			dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.SOURCE_CHANGE));
			
			if (initialized && _autoPlay)
				playVideo();
		}
		
		public function get state():String { return _state; }
		public function set state(value:String):void
		{
			if (value == _state) return;
			
			_state = value;
			
			dispatchEvent(new VideoDisplayEvent(VideoDisplayEvent.STATE_CHANGE));
		}
		
		public function get autoPlay():Boolean { return _autoPlay; }
		public function set autoPlay(value:Boolean):void
		{
			_autoPlay = value;
		}
		
		public function get volume():Number { return _stream.soundTransform.volume; }
		public function set volume(value:Number):void
		{
			var trans:SoundTransform = _stream.soundTransform;
			trans.volume = value;
			_stream.soundTransform = trans;
		}
		
		public function get autoSizeLayout():Boolean { return _autoSizeLayout; }
		public function set autoSizeLayout(value:Boolean):void
		{
			_autoSizeLayout = value;
		}
		
		public function get bufferLength():Number 
		{ 
			if (_stream)
				return _stream.bufferLength;
			return 0;
		}
		
		public function get bufferTime():Number { return _bufferTime; }
		public function set bufferTime(value:Number):void
		{
			_bufferTime = value;
			
			if (_stream)
				_stream.bufferTime = _bufferTime;
		}

	}

}