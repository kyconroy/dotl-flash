package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.states.World;
	import com.darkdefense.logging.*;
	import FGReplay.*;
	import org.flixel.*;
	import flash.errors.IOError;
	
	/**
	 * ...
	 * @author David Truong
	 */
	public class LoggingWorld extends World
	{
		public static var log:logItems;
		protected var currentLevelID:String;
		protected var currentLoggingLevel:loggingLevel;
		private var callBackCounter:Number;
		private var maxCallBacks:Number;
		
		override public function LoggingWorld(ParentWorld:World):void 
		{
			super(ParentWorld);
			
		}
		
		override public function create():void {
			super.create();
			addWorlds();
		}
		
		public function addWorlds():void {
			log = new logItems();
			addButton(new TowerStatsWorld(this), null, "Tower Stats", true);
			addButton(new LevelStatsWorld(this), null, "Level Stats", true);
			addButton(new PlaysStatsWorld(this), null, "Total Plays", true);
			addButton(new ReturnRateGraph("Return Rate", this), null, "return rate", true);
			CapstoneReplay.loadLevels("DOTLPublicRelease55", getGames); //DarkDefenseKat201005238
		}
		
		public function getGames(listItems:Array):void  {
			callBackCounter=0;
			maxCallBacks=0;
			//for each (var item:String in listItems) {
				//trace(item);
				//var line:Array = item.split("|");
				CapstoneReplay.loadEvents(42, getEvents);
				maxCallBacks++;
			//}
			FlxG.log("Max: " + maxCallBacks);
		}
		
		private function getEvents(listItems:Array):void {
			callBackCounter++;	
			//FlxG.log(listItems);
			for each (var item:String in listItems) {
				//FlxG.log(item);
				if (item == null) {
					FlxG.log("Attempting get null string.");
					continue;
				}
				var entry:Array = item.split("|"); 
				if (entry.length != 3) {
					FlxG.log("Attempting to split malformed string.");
					continue;
				}
				
				var key:String = entry[0]; //"type"
				var data:String = entry[1]; // data
				var time:String = entry[2]; // time

				switch(key) {
					case "UserPlayCount": 
						log.addPlayerData(data);
						break;
					case "levelOver":
						log.addData(data, time, currentLoggingLevel);
						break;
					case "TowerBuild": 
						//FlxG.log("adding Tower");
						log.addTowerData(data, time, currentLoggingLevel);
						break;
					case "TowerUpgraded": 
						log.addUpgradedTowerData(data, time, currentLoggingLevel);
						break;
					case "StartLevel":
						var found:Boolean = false;
						for each(var loglevel:loggingLevel in log.allLevels) {
							if (loglevel.level == data) {
								currentLoggingLevel = loglevel;
								found = true;
								break;
							}
						}
						if (!found){
							var newloggingLevel:loggingLevel = new loggingLevel(data);
							log.allLevels.push(newloggingLevel);
							currentLoggingLevel = newloggingLevel;
						}
						currentLoggingLevel.levelStarts++;
						break;
					default:
						break;							
				}
			}
			if (callBackCounter == maxCallBacks) {
				FlxG.log("finished");
			}
		}
	}
}