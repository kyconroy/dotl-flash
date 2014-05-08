package com.darkdefense.states 
{
	import flash.errors.IOError;
	import org.flixel.FlxState;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author ...
	 */
	public class RedirectState extends FlxState
	{
		private const _TARGET_URL:String = "http://www.kongregate.com/games/saralene/defenders-of-the-light?sfa=facebook&referrer=djtruong";
		override public function RedirectState():void
		{
			super();
			var txt:FlxText = new FlxText(0, 175, 800, "Please visit: " + _TARGET_URL + " to play.");
			txt.setFormat("diavlo", 48, 0xffffffff, "center");
			this.add(txt);
			try {
				navigateToURL(new URLRequest(_TARGET_URL), "_parent");
			} catch (e:SecurityError) {
				;
			} catch (e2:IOError) {
				;
			} catch (e3:Error) {
				;
			}
		}
		
	}

}