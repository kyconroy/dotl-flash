package FGReplay
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.Timer;
	import flash.errors.*;
	import org.flixel.*;
	
	import mx.collections.ArrayCollection;
	
	public class CapstoneReplay
	{
		public var verbose:Boolean = false;
		protected var m_startTime:int;
		protected var m_lid:uint;
		
		protected var m_buffer:ArrayCollection = new ArrayCollection();
		protected var m_bufferTimer:Timer;
		
		protected var m_urlRequest:URLRequest;
		protected var m_urlLoader:URLLoader;

		protected var m_bufferInterval:int;
		
		protected var m_lock:Boolean = false;

		public static const MIN_BUFFER_INTERVAL:uint =  2000;
		public static const MAX_BUFFER_INTERVAL:Number = 60000;

		public function CapstoneReplay(lid:uint):void {
			m_startTime = new Date().time;
			m_lid = lid;

			m_bufferInterval = MIN_BUFFER_INTERVAL;
			resetTimer();
		}
		
		public function restartTimer():void {
			m_startTime = new Date().time;
		}
		
		public function addEvent(type:String, data:String = ""):void {
			if (verbose) trace("add event. size: " + m_buffer.length);
			if (data == null) {
				trace("Data passed into addEvent should not be null.");
			}
			var ce:CapstoneEvent = new CapstoneEvent();
			ce.type = type;
			ce.data = data;
			ce.time = new Date().time;
			m_buffer.addItem(ce);
			//if (!m_bufferTimer.running) {
				//m_bufferTimer.start();
			//}
			resetTimer();
		}
		
		protected var m_map:Object;
		
		public function sendEvents(e:Event = null):void {
			//trace("current interval: " + m_bufferInterval);
			m_bufferTimer = null;

			//m_bufferTimer.stop();
			//m_bufferTimer.reset();
			
			//trace("tried to send events");
			
			if (m_lock) {
				m_buffer.removeAll();
				return;
			}
			
			if (m_buffer.length == 0) {
				resetTimer();
				return;
			}
			
			var _url:String = "http://foldit-web01.cs.washington.edu/comm/real_capstone_event";
			//var _url:String = "http://games.cs.washington.edu/";
			var url:String = _url + "?" + "numEvents=" + m_buffer.length + "&";
			for (var i:uint = 0; i < m_buffer.length; i++) {
				var ce:CapstoneEvent = m_buffer[i] as CapstoneEvent;
				url += "lid" + i + "=" + m_lid + "&" +
					"type" + i + "=" + ce.type + "&" +
					"data" + i + "=" + ce.data + "&" +
					"time" + i + "=" + ce.time;
				if (i < m_buffer.length - 1) {
					url += "&";
				}
			}
			
			trace("Sending to server: " + url);
			m_urlRequest = new URLRequest(url);
			m_urlRequest.method = URLRequestMethod.GET;
			m_urlLoader = new URLLoader();
			
			var t:Timer = new Timer(20000, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, function f(e:TimerEvent):void {
				t.removeEventListener(TimerEvent.TIMER_COMPLETE, f);
				sendResultBad();
			});
			t.start();
			
			m_buffer.removeAll();
			
			m_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function (e:HTTPStatusEvent):void {
				if ((e.status != 200)&&(e.status != 0)) {
					trace("Unable to store event to server: " + e.status);
				} else {
					t.stop();
					sendResultGood();
				}
			});
			m_urlLoader.addEventListener(Event.COMPLETE, function (e:Event):void {
			});
			m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
				/*
				Apparently, flash occasionally throws IO errors even when the request went through
				succesfully (http status 200).  If this fires, don't worry too much about it as
				long as the events are being stored to the server.
				*/
				sendResultBad();
				trace(e.text);
			});
			m_urlLoader.load(m_urlRequest);
		}

		// callback for result of sending data to the server came out okay
		private function sendResultGood():void {
			if (verbose) trace("success");
			
			// reduce connect interval and restart timer
			m_bufferInterval = m_bufferInterval - 10000;

			m_bufferInterval = Math.max(m_bufferInterval, MIN_BUFFER_INTERVAL);
			//m_bufferInterval = Math.min(m_bufferInterval, MAX_BUFFER_INTERVAL);
			
			resetTimer();
		}

		// callback for result of sending data to the server came out bad
		private function sendResultBad():void {
			// back off connect interval and restart timer
			trace("Increasing interval: " + m_bufferInterval);
			m_bufferInterval = 2 * m_bufferInterval;
			
			m_bufferInterval = Math.max(m_bufferInterval, MIN_BUFFER_INTERVAL);
			//m_bufferInterval = Math.min(m_bufferInterval, MAX_BUFFER_INTERVAL);
			
			if (m_bufferInterval > MAX_BUFFER_INTERVAL) {
				m_lock = true;
			}

			resetTimer();
		}
		
		// reset the timer
		private function resetTimer():void {
			if (m_bufferTimer == null) {
				m_bufferTimer = new Timer(m_bufferInterval, 1);
				m_bufferTimer.start();
				m_bufferTimer.addEventListener(TimerEvent.TIMER, sendEvents);
			}
		}
		

		public static function loadLevels(game:String, callback:Function):void {
			function parseResponse(e:Event):void {
				var urlLoader:URLLoader = e.target as URLLoader;
				var data:String = urlLoader.data;
				var splitData:Array = data.split("\n");
				
				var gameData:Array = new Array();
				for (var i:int = 0; i < splitData.length; i++) {
					var s:String = splitData[i] as String;
					if (s.length != 0) {
						gameData.push(GameLevel.fromString(s));
					}
				}
				callback(gameData);
			}
			
			var m_urlRequest:URLRequest;
			var m_urlLoader:URLLoader;
			var url:String = "http://foldit-web01.cs.washington.edu/comm/capstone_replay?type=levels&game=" + game;
			m_urlRequest = new URLRequest(url);
			m_urlRequest.method = URLRequestMethod.GET;
			m_urlLoader = new URLLoader();
			m_urlLoader.addEventListener(Event.COMPLETE, parseResponse);
			m_urlLoader.load(m_urlRequest);
		}
		
		/*
		callback is a function that takes an array of events
		*/
		public static function loadEvents(lid:uint, callback:Function):void {
			function parseResponse(e:Event):void {
				var urlLoader:URLLoader = e.target as URLLoader;
				var data:String = urlLoader.data;
				
				var splitData:Array = data.split("\n");
				var eventData:Array = new Array();
				for (var i:int = 0; i < splitData.length; i++) {
					var s:String = splitData[i] as String;
					if (s.length != 0) {
						eventData.push(CapstoneEvent.fromString(s));
					}
				}
				callback(eventData);
			}
			
			var m_urlRequest:URLRequest;
			var m_urlLoader:URLLoader;
			var url:String = "http://foldit-web01.cs.washington.edu/comm/capstone_replay?type=events&lid=" + lid;
			m_urlRequest = new URLRequest(url);
			m_urlRequest.method = URLRequestMethod.GET;
			m_urlLoader = new URLLoader();

			m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, CapstoneReplay.errorHandler);	
			m_urlLoader.addEventListener(Event.COMPLETE, parseResponse);
			m_urlLoader.load(m_urlRequest);
		}

		public static function errorHandler(e:IOErrorEvent):void {
			//trace("unhandled io");
		}

	}
}

