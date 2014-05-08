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
	public class LevelStatsWorld extends LoggingWorld
	{
		private var _testArray:Array;
		
		override public function LevelStatsWorld(ParentWorld:World):void 
		{
			super(ParentWorld);
		}
		
		override public function create():void {
			super.create();
			
		}
		
		override public function addWorlds():void {
			addButton(new TimeStatsWorld(this), null, "Time Stats");
			addButton(new HealthStatsWorld(this), null, "Health Stats");
			addButton(new PointsStatsWorld(this), null, "Points Stats");
			addButton(new PlaysStatsWorld(this), null, "Total Plays");

		}
	}
}