package com.darkdefense.logging 
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	/**
	 * ...
	 * @author me
	 */
	public class statItem
	{
		public var loseHow:String;
		public var points:Array;
		public var times:Array;
		public var lives:Array;
		
		public function statItem(loseHow:String) 
		{
			points = new Array();
			lives = new Array();
			times = new Array();
			this.loseHow = loseHow;
		}
		
		public function addPoints(points:String):void {
			//FlxG.log("adding to points" + this.points.length);
			this.points.push(points);
			//FlxG.log(loseHow);
			//FlxG.log(points);
		}
		
		public function addTime(time:String):void {
			this.times.push(time);
		}
		
		public function addLives(lives:String):void {
			this.lives.push(lives);
		}
		
		public function getAvgPoints(): Number
		{
			return calculateAvg(points);
		}
				
		public function getAvgTime():Number {
			return calculateAvg(times);
		}
		
		public function getAvgLives():Number {
			return calculateAvg(lives);
		}
	
		public function print(): String {
			return "Points: " + getAvgPoints() + ", Time: " + getAvgTime() + ", Lives: " + getAvgLives();
		}
		
		public function plays():Number {
			
			return points.length;
		}
		
		private function calculateAvg(a:Array):Number {
			var sum:int = 0;
			for each(var item:Number in a) {
				var num:int = item as int;
				sum += num;
			}
			return Math.round(sum / a.length);
		}
	}
}