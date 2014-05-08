package com.darkdefense.states.worlds 
{
	import com.darkdefense.logging.GraphData;
	import com.darkdefense.logging.GraphState;
	import com.darkdefense.states.World;
	import com.darkdefense.logging.*;
	import flash.utils.Dictionary;
	import org.flixel.*;
	import com.darkdefense.states.worlds.LoggingWorld;
	/**
	 * ...
	 * @author David Truong
	 */
	public class PointsStatsWorld extends LoggingWorld
	{
		//private var _testArray:Array;
		private var pointStrings:Dictionary;
		
		override public function PointsStatsWorld(ParentWorld:World):void 
		{
			super(ParentWorld);
		}
		
		override public function create():void {
			super.create();
		}
		
		override public function addWorlds():void {
			//FlxG.log("start adding level Points buttons");
			pointStrings = new Dictionary();
			
			for each (var level:loggingLevel in LoggingWorld.log.allLevels) {
				var worldNum:String = level.level.charAt(0);
				if (pointStrings[worldNum] == null) pointStrings[worldNum] = new Array();
				updateDictionary(level);
			}
			
			for each (var s:Array in pointStrings) {
				s.sort()
				//FlxG.log(s);
				addButton(new GraphState(new GraphData(s), "World "+ s[0].charAt(0)+" Avg Points", this), null, "World "+s[0].charAt(0), true);
			}
		}
		
		private function updateDictionary(level:loggingLevel):void {
			var levelDataString:String = level.level;
			var worldNum:String = level.level.charAt(0);
			for each(var how:statItem in level.states){
				levelDataString += "/" + how.loseHow + "@" + how.getAvgPoints();
			}
			pointStrings[worldNum].push(levelDataString);
		}
	}
}