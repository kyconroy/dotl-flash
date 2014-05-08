package com.darkdefense 
{
	import FGReplay.*;
	import flash.utils.Dictionary;
	import org.flixel.data.FlxKong;
	import org.flixel.FlxG;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author me
	 */
	public class PlayerStats
	{
		//level information
		public static var LevelInfo:Array;
		public static var LevelLoggingId:int;
		
		//meta-upgrade info
		public static var MaxUpgradePoints:int;
		public static var DamagePoints:int;
		public static var SpeedPoints:int;
		public static var RangePoints:int;
		public static var CooldownPoints:int;
		
		public static const DAMAGE_BOOST:Number = 0.025;
		public static const SPEED_BOOST:Number = 0.025;
		public static const RANGE_BOOST:Number = 0.025;
		public static const COOLDOWN_BOOST:Number = 0.015;
		
		public var levelLogging:GameLevel;
		public static var LevelPlayCounter:Number;
		public static var UnlockedLevels:String = "";
		public static var Muted:Boolean;
		public static var Volume:Number;
		
		public override function PlayerStats():void 
		{			
			LevelInfo = new Array();
			MaxUpgradePoints = 0;
			DamagePoints = 0;
			SpeedPoints = 0;
			RangePoints = 0;
			CooldownPoints = 0;
			LevelPlayCounter = 0;
			UnlockedLevels = "";
			Volume = 0.75;
			Muted = false;
			
			//LevelLoggingId = 55;        //Change for different releases
			LevelLoggingId = 42;		//Dev logging ID
			FlxG.log("Release Version: " + LevelLoggingId);
			
			FlxG.flxSave = SharedObject.getLocal("DOTL"+LevelLoggingId);

			if (FlxG.flxSave != null) {
				if (FlxG.flxSave.data["counter"] == null)
					initSave("counter");
				else
					saveData("counter", getSave("counter") + 1);
				MaxUpgradePoints = getSave("upgradepoints");
				DamagePoints = getSave("damage");
				SpeedPoints = getSave("speed");
				RangePoints = getSave("range");
				CooldownPoints = getSave("cooldown");
				UnlockedLevels = getSave("unlockedlevels");
				Muted = getSave("muted");
				Volume = getSave("volume");
				if (UnlockedLevels == null) UnlockedLevels = "";
				if (!(Volume >= 0)) Volume = 0.75;
			} else {
				initSave("counter");
				initSave("world");
				initSave("upgradepoints");
				initSave("damage");
				initSave("speed");
				initSave("range");
				initSave("cooldown");
				initSave("current");
				initSave("unlockedlevels");
				initSave("muted");
				initSave("volume");
				saveData("counter", 1);
			}
			levelLogging = new GameLevel(LevelLoggingId, "DOTLPublicRelease"+LevelLoggingId, ""+new Date().time); //"DarkClassRelease50"
			levelLogging.reportGame();
			
			var loggingEvents:CapstoneReplay = new CapstoneReplay(PlayerStats.LevelLoggingId);
			loggingEvents.addEvent("UserPlayCount", FlxG.flxSave.data["counter"]);		
		}

		public static function getLevelStats(level:String):LevelStats
		{
			var lstats:LevelStats = null;
			if (LevelInfo[level] != undefined) lstats = LevelInfo[level];
			else LevelInfo[level] = lstats = new LevelStats();
			return lstats;
		}
		
		public static function initSave(id:String, value:* = 0):void
		{
			if (!FlxG.flxSave.data.hasOwnProperty(id)) {		
				FlxG.flxSave.data[id] = value;
				FlxG.flxSave.flush();
			}
		}
		
		public static function saveData(id:String, value:*):void
		{
			FlxG.flxSave.data[id] = value;
			FlxG.flxSave.flush();
		}
		
		public static function getSave(id:String):*
		{
			return FlxG.flxSave.data[id];
		}
		
		public static function saveStats():void 
		{
			saveData("upgradepoints", MaxUpgradePoints);
			saveData("damage", DamagePoints);
			saveData("speed", SpeedPoints);
			saveData("range", RangePoints);
			saveData("cooldown", CooldownPoints);
			saveData("unlockedlevels", UnlockedLevels);
			saveData("muted", Muted);
			saveData("volume", Volume);
		}
		public static function loadVolume():void {
			Muted = getSave("muted");
			Volume = getSave("volume");
			if (!(Volume >= 0)) Volume = 0.75;
			FlxG.mute = PlayerStats.Muted;
			FlxG.volume = PlayerStats.Volume;
		}
		public static function saveVolume():void {
			Muted = FlxG.mute;
			Volume = FlxG.volume;
			saveData("muted", Muted);
			saveData("volume", Volume);
		}
	}
}