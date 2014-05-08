package com.darkdefense.states
{
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.*;
	import com.darkdefense.Parser;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	public class Tutorial extends Level
	{
		override public function Tutorial(LevelSpec:Class, ParentOverWorld:OverWorld, NextState:GameState):void
		{
			super(LevelSpec, ParentOverWorld, NextState, null, false);
			this.defaultGroup.remove(ui);
			ui = new UI(this, false);
			this.add(ui);
            this.active = false;
			ui.timeSinceLastBuild = 0;
            canWin = false;
		}
        
		override public function create():void {
			FlxG.mouse.show();
			this.fog = new Fog(this.lights);
			Parser.parseLevel(this, 0, 0, _levelSpec);
			if (messageHead == null) {
				waveHead.start();
			} else {
				messageHead.start(waveHead);
			}
		}
	}
}