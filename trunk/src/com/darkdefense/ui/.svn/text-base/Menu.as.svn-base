package com.darkdefense.ui 
{
	import com.darkdefense.states.Level;
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import com.darkdefense.states.OverWorld;
	import DarkDefense;
	
	public class Menu extends FlxGroup
	{
		//[Embed(source = "../../../assets/fonts/Diavlo_MEDIUM_II_37.otf", fontFamily = "system")] private var diavlo:String;
		
		private var _level:Level;
		private var _enemySpeed:Number;
		private var _buildSpeed:Number;
		private var _upgradeSpeed:Number;
		private var _bX:Number = 0.83 * Tile.TILESIZE;
		private var _bY:Number = -0.9 * Tile.TILESIZE;
		private var _numButtons:int = 0;
		private var _mute:Boolean;
		override public function Menu(ParentLevel:Level):void
		{
			super();
			
			_level = ParentLevel;
			_level.ui.menuButtonActive = true;
			this.width = 6.66 * Tile.TILESIZE;
			this.height = 5 * Tile.TILESIZE;
			// Position in the lower left corner.  
			_enemySpeed = _level.enemySpeed;
			_buildSpeed = _level.buildSpeed;
			_upgradeSpeed = _level.upgradeSpeed;
			_level.gameSpeed = 0;
			
			var backgroundSprite:FlxSprite = new FlxSprite(0, 0);
			backgroundSprite.createGraphic(this.width, this.height, 0xff666666);
			this.add(backgroundSprite);
			
			addButton("[Q] Quit Level", returnToMap);
			addButton("[R] Restart", restartLevel);
			addButton("[TAB] Cancel", kill);
			this.x = 20 * Tile.TILESIZE;
			this.y = 18.5 * Tile.TILESIZE - _bY;
			
			_mute = FlxG.mute;
			_level.ui.add(DarkDefense.pauseGroup);
			DarkDefense.pauseGroup.visible = false;
			FlxG.mute = true;
			this.visible = false;
		}
		
		public function restartLevel():void {
			kill();
			FlxG.state = _level.freshLevel();
		}
		public function returnToMap():void {
			_level.loggingEvents.addEvent("levelOver", _level.fullLevelID + "/Abandon/" + _level.gameScore + "/" + _level.playerBase.health);
			kill();
			FlxG.state = _level.parentWorld;
		}
		private function addButton(Text:String, Callback:Function):void {
			_bY += 1.2 * Tile.TILESIZE;
			var button:FlxButton = new FlxButton(_bX, _bY, Callback);
			button.width = 5 * Tile.TILESIZE;
			button.height = Tile.TILESIZE;
			button.scrollFactor = new FlxPoint(0, 0);
			var txt:FlxText = new FlxText(0, 0.125 * Tile.TILESIZE, button.width, Text);
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			var img:FlxSprite = new FlxSprite();
			img.createGraphic(button.width, button.height, 0xff999999);
			button.loadText(txt);
			button.loadGraphic(img);
			this.add(button);
		}
		override public function kill():void {
			super.kill();
			_level.enemySpeed = _enemySpeed;
			_level.buildSpeed = _buildSpeed;
			_level.upgradeSpeed = _upgradeSpeed;
			_level.ui.remove(DarkDefense.pauseGroup);
			FlxG.mute = _mute;
			new TimedCallback(_level, 0.1, deactivateMenuButton );
		}
		override public function update():void {
			super.update();
			DarkDefense.pauseGroup.visible = true;
			this.visible = true;
			if (FlxG.keys.justReleased("ESCAPE") || FlxG.keys.justReleased("TAB")) {
				kill();
			}
			if (FlxG.keys.justReleased("R")) restartLevel();
			if (FlxG.keys.justReleased("Q")) returnToMap();
		}
		private function deactivateMenuButton():void {
			_level.ui.menuButtonActive = false
		}
	}

}