package com.darkdefense.states 
{
	import org.flixel.data.FlxKong;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import com.darkdefense.PlayerStats;
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	
	public class GameState extends FlxState
	{
		public var title:String;
		protected var _isLevel:Boolean = false;
		
		public function GameState() 
		{
			super();
		}
		
		public override function update():void
		{
			if (!FlxG.kong) (FlxG.kong = parent.addChild(new FlxKong())as FlxKong).init();
			super.update();
		}
		
		public function set levelNum(i:int):void { }
		public function set worldNum(i:int):void { }
		public function get levelNum():int { return -1 }
		public function get worldNum():int { return -1 }
		public function get fullLevelID():String { return null }
		public function get isLevel():Boolean { return _isLevel; }
		public function nextLevel():void {}
	}

}