package com.darkdefense.logging 
{
	
	import org.flixel.*;
	import com.darkdefense.logging.TowerStats;
	/**
	 * ...
	 * @author me
	 */
	public class logItems
	{
		public var allLevels:Array;
		static public var plays:Array;
		
		public function logItems()
		{
			allLevels = new Array();
			plays = new Array();
		}
		
		//type| tower, X, Y | time
		//TowerBuild|LanternTower@480,300|13
		// levelEnd | Level, How, points, lives | time
		// PlayerHealth | Base Damaged | time
		
			/*
			 * [0] Win: Points, AVG Time, AVG Lives
			 * [1] Abandon: Points, AVG Time, AVG Lives
			 * [2] Lose: Points, AVG Time
			 * */
		public function addData(s:String, time:String, currentLevel:loggingLevel):void {
			//FlxG.log("In addData " + s + " @ " + time);
			var dataElements:Array = s.split("/");
			//FlxG.log(dataElements);
			var how:String = dataElements[1];
			if (how == "Win") {
				//FlxG.log("in how inside of addData");
				currentLevel.updateStatus(dataElements[2], time, dataElements[3], currentLevel.wins); //points, time, lives
			}
			else if (how == "Abandon") currentLevel.updateStatus(dataElements[2], time, dataElements[3], currentLevel.abandon);
			else if (how == "Lose")currentLevel.updateStatus(dataElements[2], time, dataElements[3], currentLevel.lose);
		}
		
		public function addTowerData(s:String, time:String, currentLevel:loggingLevel):void {
			var dataElements:Array = s.split("@");
			if (dataElements.length == 3){
				if (currentLevel.towerStat.allTowers[dataElements[1]] == null) currentLevel.towerStat.allTowers[dataElements[1]] = new Array(dataElements[1], new Number(), new Number);
				currentLevel.towerStat.allTowers[dataElements[1]][1]++;
			} else if (dataElements.length == 2) {
				var levelTower:String = dataElements[0];
				var levelID:String = levelTower.substr(0, 3);
				var towerID:String = levelTower.substring(3);
				
				if (currentLevel.towerStat.allTowers[towerID] == null) currentLevel.towerStat.allTowers[towerID] = new Array(towerID, new Number(), new Number());
				currentLevel.towerStat.allTowers[towerID][1]++;
			} else {
				FlxG("you fail at logging");
			}
		}
		
		public function addUpgradedTowerData(s:String, time:String, currentLevel:loggingLevel):void {
			var dataElements:Array = s.split("@");

			var baseTower:String;
			if (dataElements.length == 3){

				baseTower = dataElements[1].replace("Upgraded", "");
				if (currentLevel.towerStat.allTowers[baseTower] == null) currentLevel.towerStat.allTowers[baseTower] = new Array(baseTower, new Number(), new Number());
				//FlxG.log(baseTower);

				currentLevel.towerStat.allTowers[baseTower][2]++;
			} else if (dataElements.length == 2) {
				var levelTower:String = dataElements[0];
				var levelID:String = levelTower.substr(0, 3);

				var towerID:String = levelTower.substring(3);

				baseTower = towerID.replace("Upgraded", "");
				if (currentLevel.towerStat.allTowers[baseTower] == null) currentLevel.towerStat.allTowers[baseTower] = new Array(baseTower, new Number(), new Number());
				currentLevel.towerStat.allTowers[baseTower][2]++;
			} else {
				FlxG("you fail at logging");
			}
		}
		
		public function addPlayerData(count:String):void {
			trace("plays: " + count);
			if (plays[count] == null) plays[count] = new Number();
			plays[count]++;
		}
	}
}