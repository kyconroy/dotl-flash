package com.darkdefense.states
{
	/**
	 * ...
	 * @author David
	 */
	import org.flixel.*;
	import FGReplay.*;
	import flash.utils.Dictionary;
	import com.darkdefense.logging.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.GameState;
	import flash.display.Graphics;
	
	public class LoggingState extends GameState
	{
		private var log:logItems;
		private var dataTxt:FlxText;
		private var dataTxt2:FlxText;
		private var _nextState:FlxState;
		private var currentLevelID:String;
		private var currentLoggingLevel:loggingLevel;
		//private var totalPlays:Number;
		
		override public function LoggingState(NextState:FlxState):void
		{
			_nextState = NextState;
			log = new logItems();
			var txtFont:String = "diavlo"
			var txtColor:uint = 0xFFBFFEBF;
			
			var txt:FlxText
			txt = new FlxText(0, 0, FlxG.width, "Analytics State")
			txt.setFormat(txtFont,16,txtColor,"center")
			this.add(txt);
			
			dataTxt = new FlxText(0, 40, FlxG.width)
			dataTxt.setFormat(txtFont,10,txtColor,"left")
			this.add(dataTxt);
			
			dataTxt2 = new FlxText(FlxG.width/2, 40, FlxG.width)
			dataTxt2.setFormat(txtFont,10,txtColor,"left")
			this.add(dataTxt2);
			
			var x:Number = 0;
			var y:Number = 0;
			var buttonwidth:Number = 120;
			var buttonheight:Number = 10;
			
			var levelData:FlxButton = new FlxButton(x, y, getLevelData);
			levelData.width = buttonwidth;
			levelData.height = buttonheight;
			levelData.loadText(new FlxText(levelData.x, levelData.y, buttonwidth, "Level Data").setFormat(txtFont, 16, txtColor));
			this.add(levelData);
			
			x = buttonwidth + Tile.TILESIZE / 2;
			var towerData:FlxButton = new FlxButton(x, y, getTowerData);
			towerData.width = buttonwidth;
			towerData.height = buttonheight;
			towerData.loadText(new FlxText(0, 0, buttonwidth, "Tower Data").setFormat(txtFont, 16, txtColor));
			this.add(towerData);
			
			y = Tile.TILESIZE;
			var towerAvgData:FlxButton = new FlxButton(x, y, getAvgTowerData);
			towerAvgData.width = buttonwidth;
			towerAvgData.loadText(new FlxText(0, 0, buttonwidth, "Avg Tower Data").setFormat(txtFont, 16, txtColor));
			this.add(towerAvgData);
			
			x = FlxG.width - buttonwidth;
			y = 0;
			var goBack:FlxButton = new FlxButton(x, y, mainMenu);
			goBack.width = buttonwidth;
			goBack.height = buttonheight;
			goBack.loadText(new FlxText(0, 0, 120, "Main Menu").setFormat(txtFont, 16, txtColor));
			this.add(goBack);
			
			//CapstoneReplay.loadEvents(2833168629, showStuff); 
		}
		public override function create():void
		{
			FlxG.log("Loading All Data...");
			CapstoneReplay.loadLevels("SingleLoggingDisplay43", showLevels);//DarkDefenseKat201005238
			//FlxG.log("Data Load Complete!");
		}
		
		private function mainMenu():void {
			FlxG.state = _nextState;
		}
		
		private function getLevelData():void {
			/*for each(var dataLevel:loggingLevel in log.allLevels) {
				FlxG.log(dataLevel.level);
			}*/
			dataTxt.text = "";
			dataTxt2.text = "Tutorials\n";
			var t:String = new String();
			var s:String = new String();
			var totalPlays:Number = 0;
			for each (var dataLevel:loggingLevel in log.allLevels){
				var levelPlays:Number = 0;
				
				if (dataLevel.level.charAt(0) =='0'){
					t+= "\n\nLevel Number: "+dataLevel.level;
					for each (var data:statItem in dataLevel.states){
						t+= "\nAverage "+data.loseHow+": ";
						t += data.print();
						t += "\t\tCount : " + data.plays();
						levelPlays += data.plays();
					}
					t += "\nLevel Plays: " + levelPlays;
				}else {
					s+= "\n\nLevel Number: "+dataLevel.level;
					for each (var data2:statItem in dataLevel.states){
						s += "\nAverage "+data2.loseHow+": ";
						s += data2.print();
						s += "\t\tCount : " + data2.plays();
						levelPlays += data2.plays();
					}
					s += "\nLevel Plays: " + levelPlays;
				}
				totalPlays += levelPlays;
			}
			t += "\n\nTotal Plays: " + totalPlays+"\n";
			//FlxG.log(t);
			dataTxt.text = t;
			dataTxt.setFormat("diavlo", 10, 0xFFBFFEBF);
			dataTxt2.text = s;
			dataTxt2.setFormat("diavlo", 10, 0xFFBFFEBF);
		}
		
		public function getTowerData():void {
			var scale:Number = 0;
			dataTxt.text = "";
			dataTxt2.text = "Tutorials\n";
			for each (var level:loggingLevel in log.allLevels) {
				//FlxG.log(level.level + " " + level.towerStat.countTotalOverallTowers());
				//FlxG.log(level.level);
				//FlxG.log(level.towerStat.returnTowerDataStringArray());
				if (level.level.charAt(0) =='0'){
					dataTxt.text += "\n"+level.level;
					for each (var s:String in level.towerStat.returnTowerDataStringArray())
						dataTxt.text += s + "\n\t";
				}else{
					dataTxt2.text += "\n"+level.level;
					for each (var str:String in level.towerStat.returnTowerDataStringArray())
						dataTxt2.text += str + "\n\t";
				}
				scale += level.towerStat.countTotalOverallTowers();
			}
		}
		
		public function drawAxes(Scale:Number):Number {
			//sort array of levels?
			var heightPerTower:Number = FlxU.floor((FlxG.height - Tile.TILESIZE) / Scale);
			var allLevelsSorted:Array = new Array();
			for each (var logLevel:loggingLevel in log.allLevels) {
				allLevelsSorted.push(logLevel.level);
			}
			allLevelsSorted = allLevelsSorted.sort(); //sorts them perfectly!
			
			//draw the x-axis
			
			
			//FlxG.log(allLevelsSorted);
			return heightPerTower;
		}
		
		public function getAvgTowerData():void {
			dataTxt.text = ""
			dataTxt2.text = "Tutorials";
			for each (var level:loggingLevel in log.allLevels) {
				//FlxG.log(level.level + " " + level.towerStat.countTotalOverallTowers());
				//FlxG.log(level.level);
				var levelPlays:Number = 0;
				for each (var data:statItem in level.states){
					levelPlays += data.plays();
				}
				
				if (levelPlays == 0) levelPlays = 1;
				if (level.level.charAt(0) =='0'){
					dataTxt.text += "\n\n"+level.level;
					dataTxt.text += "Avg Towers: " + level.towerStat.countTotalOverallTowers()/levelPlays +"\n\t"+ 
							 //"Total Overall Upgraded Towers: " + totalUpgradedTowers, 
							 "Avg Arrow Towers Built: " + level.towerStat.totalArrowTowers/levelPlays +"\n\t"+  
							 "Avg Canon Towers Built: " + level.towerStat.totalCanonTowers/levelPlays +"\n\t"+ 
							 "Avg Magic Towers Built: " + level.towerStat.totalMagicTowers/levelPlays +"\n\t"+  
							 "Avg Light Towers Built: " + level.towerStat.totalLanternTowers / levelPlays;
				} else {
					dataTxt2.text += "\n\n"+level.level;
					dataTxt2.text += "Avg Towers: " + level.towerStat.countTotalOverallTowers()/levelPlays +"\n\t"+ 
							 //"Total Overall Upgraded Towers: " + totalUpgradedTowers, 
							 "Avg Arrow Towers Built: " + level.towerStat.totalArrowTowers/levelPlays +"\n\t"+  
							 "Avg Canon Towers Built: " + level.towerStat.totalCanonTowers/levelPlays +"\n\t"+ 
							 "Avg Magic Towers Built: " + level.towerStat.totalMagicTowers/levelPlays +"\n\t"+  
							 "Avg Light Towers Built: " + level.towerStat.totalLanternTowers / levelPlays;
				}
						 
				/*FlxG.log(new Array("Avg Towers: " + level.towerStat.countTotalOverallTowers()/levelPlays, 
						 //"Total Overall Upgraded Towers: " + totalUpgradedTowers, 
						 "Avg Arrow Towers Built: " + level.towerStat.totalArrowTowers/levelPlays, 
						 "Avg Canon Towers Built: " + level.towerStat.totalCanonTowers/levelPlays, 
						 "Avg Magic Towers Built: " + level.towerStat.totalMagicTowers/levelPlays, 
						 "Avg Light Towers Built: " + level.towerStat.totalLanternTowers/levelPlays));*/
				
				//FlxG.log(level.towerStat);
			}
		}
		public function showLevels(listItems:Array):void  {
			var timestamp:int = 1274677140000;
			var timestampuint:uint = timestamp;
			for each (var item:String in listItems){
				var line:Array = item.split("|");
				//FlxG.log(line[0]);
				//if (parseFloat(line[0]) > timestampuint) {
					CapstoneReplay.loadEvents(43, showEvents);
				//}
			}
		}
		
		private function showEvents(listItems:Array):void {
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
				//FlxG.log(key);
				var data:String = entry[1]; // data
				var time:String = entry[2]; // time
				//FlxG.log(time);
				//var dataElements:Array;
				
				switch(key) {
					case "levelOver":
						log.addData(data, time, currentLoggingLevel);
						FlxG.log("levelOver for" + currentLoggingLevel.level);
						break;
					case "TowerBuild": 
						log.addTowerData(data, time, currentLoggingLevel);
						break;
					case "TowerUpgraded": 
						log.addUpgradedTowerData(data, time, currentLoggingLevel);
						break;
					case "StartLevel":
						//FlxG.log("start level: " + data);
						var found:Boolean = false;
						for each(var loglevel:loggingLevel in log.allLevels) {
							if (loglevel.level == data) {
								//FlxG.log("loglevel: " + loglevel.level);
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
						//FlxG.log("allLevels: " + log.allLevels);
						break;
					default:
						//FlxG.log("other stuff");
						break;							
						
				}
			}
			FlxG.log("total Plays: "+currentLoggingLevel.wins.plays());
		}
	}
}