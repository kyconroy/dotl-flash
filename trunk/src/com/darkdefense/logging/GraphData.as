package com.darkdefense.logging 
{
	import flash.utils.Dictionary;
	import org.flixel.*;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class GraphData
	{
		private var _dataArray:Array;
		
		public var xScale:Number;
		public var yScale:Number;
		
		public var xAxisLabel:Array;
		private var levelNum:FlxText;
		
		//String format for reference
		//"0-2/Win@10/Abandon@6/Lose@3"
		//"0-3/Win@20/Abandon@5/Lose@10"
		//"0-4/Win@15/Abondon@3/Lose@8"
		
		public function GraphData(Data:Array):void 
		{
			_dataArray = Data;
		}
		
		public function createBars(screen:GraphState):void {
			var usableSizeX:Number = FlxG.width - 200;
			
			var currentX:Number = 0;
			var size:Number = usableSizeX / _dataArray.length/3;
			
			var bars:Array = new Array();
			var maxValue:Number = 0;
			
			
			for each (var levelData:String in _dataArray) {
				var info:Array = levelData.split("/");
				//print level Number info[0]
				var win:Array = info[1].split("@");
				var current:String = win[1];
				
				if (parseFloat(win[1])){
					bars.push(new GraphBar(100 + currentX * size, FlxG.height - 50, size, win[1], 0x7FFF00));
					levelNum = new FlxText(100 + currentX * size, FlxG.height - 40, FlxG.width)
					levelNum.setFormat(screen.txtFont,10,screen.txtColor,"left")
					levelNum.text = info[0].charAt(2);
					screen.add(levelNum);
				}
				if (win[1] > maxValue) maxValue = win[1];
				currentX+=1;
				
				var abandon:Array = info[2].split("@");
				if (parseFloat(abandon[1]))
					bars.push(new GraphBar(100 + currentX* size, FlxG.height - 50, size, abandon[1], 0xFF0000));
				if (abandon[1] > maxValue) maxValue = abandon[1];
				currentX+=1;
				
				var lose:Array = info[3].split("@");
				if (parseFloat(lose[1]))
					bars.push(new GraphBar(100 + currentX* size, FlxG.height - 50, size, lose[1], 0x0000FF));
				if (lose[1] > maxValue) maxValue = lose[1];
				currentX+=1;
			}
			
			for each (var gBar:GraphBar in bars) {
				var value:Number = gBar._height;
				gBar.updateMax(maxValue);
				screen._graphBars.add(gBar);
				levelNum = new FlxText(gBar._x, gBar._y - gBar._height / maxValue * 450 - 20, FlxG.width);
				levelNum.setFormat(screen.txtFont, 10, screen.txtColor, "left");
				levelNum.text = value.toString();
				screen.add(levelNum);
			}
		}
	}
}