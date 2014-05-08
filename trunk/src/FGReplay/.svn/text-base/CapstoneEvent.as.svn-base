package FGReplay 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	public class CapstoneEvent
	{
		public var verbose:Boolean = false;
		public var type:String;
		public var data:String;
		public var time:Number;
		
		private var m_urlRequest:URLRequest;
		private var m_urlLoader:URLLoader;
		
		public function CapstoneEvent():void {
		}
		
		public function sendToServer(lid:uint, _url:String):void {
			if (_url == null) {
				trace("passed in url cannot be null.");
			}
			var url:String = _url + "?" +
			"lid=" + lid + "&" +
			"type=" + type + "&" +
			"data=" + data + "&" +
			"time=" + time;
			if (verbose) trace("Sending to server: " + url);
			m_urlRequest = new URLRequest(url);
			m_urlRequest.method = URLRequestMethod.GET;
			m_urlLoader = new URLLoader();
			m_urlLoader.load(m_urlRequest);
			m_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function (e:HTTPStatusEvent):void {
				if (e.status != 200) {
					trace("Unable to store event to server: " + e.status);
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
		
		/*
		Event data has to be flattened to a string when retrieving information
		from the server, as well as when trying to store data locally.
		The local data store can't handle arrays of arbitrary objects,
		but can handle arrays of strings.
		*/
		public function toString():String {
			return type + "|" + data + "|" + time.toString();
		}
		/*
		Notice that this fails if the "data" contains |...
		*/
		public static function fromString(s:String):CapstoneEvent {
			if (s == null) {
				trace("Attempting to populate CapstoneEvent with null string.");
				return null;
			}
			var a:Array = s.split("|");
			if (a.length != 3) {
				trace("Attempting to populate CapstoneEvent with malformed string.");
				return null;
			}
			var d:CapstoneEvent = new CapstoneEvent();
			d.type = a[0];
			d.data = a[1];
			d.time = a[2];
			return d;
		}
	}
}