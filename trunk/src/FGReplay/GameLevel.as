package FGReplay
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	public class GameLevel
	{
		public var lid:uint;
		public var game:String;
		public var parameters:String;
		
		private var m_urlRequest:URLRequest;
		private var m_urlLoader:URLLoader;
		
		public function GameLevel(_lid:uint, _game:String, _params:String)
		{
			if (_params.indexOf("|") != -1) {
				trace("Params should not have the | character.");
			}
			lid = _lid;
			game = _game;
			parameters = _params;
		}
		
		public function toString():String {
			return lid + "|" + game + "|" + parameters;
		}
		
		public static function fromString(s:String):GameLevel
		{
			var data:Array = s.split("|");
			if (data.length != 3) {
				trace("Incorrect amount of data when creating GameLevel from string: " + s);
			}
			
			return new GameLevel(uint(data[0]), data[1], data[2]);
		}
		
		public function reportGame():void
		{
			var url:String = "http://foldit-web01.cs.washington.edu/comm/real_capstone_level?" +
			//var url:String = "http://games.cs.washington.edu/?" +
			"lid=" + lid + "&" +
			"game=" + game + "&" +
			"parameters=" + parameters;
			
			trace("Reporting game level: " + url);
			m_urlRequest = new URLRequest(url);
			m_urlRequest.method = URLRequestMethod.GET;
			m_urlLoader = new URLLoader();
			m_urlLoader.load(m_urlRequest);
			m_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function (e:HTTPStatusEvent):void {
				if ((e.status != 200)&&(e.status != 0)) {
					trace("Unable to store game to server: " + e.status);
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
				trace(e.text);
			});
			
		}
	}
}