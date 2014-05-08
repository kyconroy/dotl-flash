package com.darkdefense.states.worlds 
{
	import com.darkdefense.logging.GraphData;
	import com.darkdefense.logging.GraphState;
	import com.darkdefense.states.World;
	import com.darkdefense.logging.*;
	import org.flixel.*;
	import com.darkdefense.states.worlds.LoggingWorld;
	/**
	 * ...
	 * @author David Truong
	 */
	public class TowerStatsWorld extends LoggingWorld
	{
		
		private var _testArray:Array;		
		
		override public function TowerStatsWorld(ParentWorld:World):void 
		{
			super(ParentWorld);
		}
		
		override public function create():void {
			super.create();
		}
		
		override public function addWorlds():void {
			
			FlxG.log("start adding world tower Buttons");
			
			for each (var level:loggingLevel in LoggingWorld.log.allLevels) {
				var worldNum:String = level.level.charAt(0);
				var sum:Number = 0;
				//FlxG.log(level.level)
				addButton(new TowerGraphState(level.towerStat, level.level), null, level.level, true);
				for each (var count:Array in level.towerStat.allTowers){
					//sum += count[1];
					//FlxG.log("\t" +count[0] + " tower count: " + count[1]);
					//FlxG.log("\t upgraded" + count[2]);
				}
					
				//if (towerStrings[worldNum] == null) towerStrings[worldNum] = new Array();
				//updateDictionary(level);
			}
			
		}
	}
}