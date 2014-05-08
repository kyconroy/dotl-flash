package com.darkdefense.logging 
{
	import org.flixel.*
	/**
	 * ...
	 * @author me
	 */
	public class loggingLevel
	{
		public var level:String;
		public var wins:statItem;
		public var lose:statItem;
		public var abandon:statItem;
		public var states:Array;
		public var towerStat:TowerStats;
		public var levelStarts:Number;
		
		public function loggingLevel(LevelID:String):void
		{
			level = LevelID;
			wins = new statItem("Win");
			lose = new statItem("Lose");
			abandon = new statItem("Abandon");
			states = new Array(wins, abandon, lose);
			towerStat = new TowerStats();
			levelStarts = 0;
		}	
		
		public function updateStatus(points:String, time:String, lives:String, thisStatItem:statItem):void {
			FlxG.log("updating status of logginglevel " + level);
			thisStatItem.addPoints(points);
			thisStatItem.addTime(time);
			thisStatItem.addLives(lives);
		}
	}
}