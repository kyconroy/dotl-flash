package com.darkdefense.states
{
	import com.darkdefense.LevelStats;
	import flash.media.Sound;
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.towers.*;
    import com.darkdefense.states.worlds.TutorialWorld;
	import com.darkdefense.states.worlds.*;
	import com.darkdefense.PlayerStats;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class OverWorld extends World
	{	
		[Embed(source = '../../../assets/sounds/Overworld.mp3')] private var OverworldMusic:Class;
		
		//Building levels? Change this file to test them using the Test button
		[Embed(source = '../../../assets/levels/z_test.txt', mimeType = "application/octet-stream")] private var TestLevel:Class;
		[Embed(source = '../../../assets/images/Level1-2.jpg')] private var Level1_1:Class;
		[Embed(source = '../../../assets/images/Level2-1.jpg')] private var Level2_1:Class;
		[Embed(source = '../../../assets/images/Level3-1.jpg')] private var Level3_1:Class;
		[Embed(source = '../../../assets/images/Level3-1.jpg')] private var Level4_1:Class;
		[Embed(source = '../../../assets/images/Level3-1.jpg')] private var Level5_1:Class;
		[Embed(source = '../../../assets/images/Level3-1.jpg')] private var Level6_1:Class;
		
		//private vars 
		private var _buttonWidth:Number = 3 * Tile.TILESIZE;
		private var _buttonHeight:Number = 2 * Tile.TILESIZE;
		
		private const VALID_DOMAINS:Array = [
			"kongregate.com",
			//"cs.washington.edu",
			"newgrounds.com",
			"ungrounded.net"
		];
		
		override public function OverWorld():void 
		{
			super(null, OverworldMusic, "Defenders of the Light");

			var unlockedLevels:Array = PlayerStats.UnlockedLevels.split("|");
			var stat:LevelStats;
			for each (var lvlS:String in unlockedLevels) {
				stat = PlayerStats.getLevelStats(lvlS);
				stat.enabled = true;
				stat.currentScore = PlayerStats.getSave(lvlS);
			}
			PlayerStats.loadVolume();
		}
		
		override public function create():void {
			siteLock();
			super.create();
			PlayerStats.LevelPlayCounter++;
			FlxG.mouse.show();
			//FlxG.mouse
			
			//CONFIG::debug
			//{
				/*addButton(new Level(TestLevel, this, this, null ,null, true, 0xff, true, true), null, "Testing Level", true);
				addButton(new LoggingState(this), null, "Statistics State", true);
				addButton(new LoggingWorld(this), null, "Statistics World", true);*/
			//}

			//addButton(new TutorialWorld(this,_music), null, "Tutorial", true);
			addButton(new World1(this), Level1_1, "World 1", true);
			addButton(new World2(this), Level2_1, "World 2");
			addButton(new World3(this), Level3_1, "World 3");
			addButton(new World4(this), Level4_1, "World 4");	
			addButton(new World5(this), Level5_1, "World 5");
			addButton(new World6(this), Level6_1, "World 6");
			addButton(new CreditsWorld(this), null, "Credits");
		}
		
		private function siteLock():void
		{
			var onMySite:Boolean = false;
			for each (var url:String in VALID_DOMAINS)
				onMySite ||= (root.loaderInfo.url.indexOf(url) >= 0);
				
			onMySite ||= (root.loaderInfo.url.indexOf("file") >= 0);
			/*var url:String = stage.loaderInfo.url;
			var urlStart:Number = url.indexOf("://") + 3;
			var urlEnd:Number = url.indexOf("/", urlStart);
			var domain:String = url.substring(urlStart, urlEnd);
			var LastDot:Number = domain.lastIndexOf(".") - 1;
			var domEnd:Number = domain.lastIndexOf(".", LastDot) + 1;
			domain = domain.substring(domEnd, domain.length);*/
			
			
			if (!onMySite)
			{
				FlxG.state = new RedirectState();
			}
		}
	}
}