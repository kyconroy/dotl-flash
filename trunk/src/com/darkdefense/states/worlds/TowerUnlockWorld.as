package com.darkdefense.states.worlds 
{
	import com.darkdefense.LevelStats;
	import com.darkdefense.states.GameState;
	import com.darkdefense.states.Level;
	import com.darkdefense.states.World;
	import flash.display.Sprite;
	import flash.media.Sound;
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.towers.*;
	import com.darkdefense.ui.*;
    import com.darkdefense.states.worlds.TutorialWorld;
	import com.darkdefense.states.worlds.*;
	import com.darkdefense.PlayerStats;
	
	/**
	 * ...
	 * @author David Truong
	 */
	public class TowerUnlockWorld extends World
	{
		private var t:Tower;
		private var tmpLevel:Level;
		private var type:Class;
		private var _damageBar:StatBar;
		private var _rangeBar:StatBar;
		private var _speedBar:StatBar;
		private var _lightrangeBar:StatBar;
		private var _towerCode:uint;
		private var _nextState:GameState;
		
		[Embed(source = "../../../../assets/images/unlockBackground.jpg")] private var grass:Class;
		
		override public function TowerUnlockWorld(TowerType:Class = null, TowerCode:uint = 0, parentWorld:World=null):void 
		{
			super(parentWorld, null, "", true);

			tmpLevel = new Level(null, this, this);
			t = new TowerType(tmpLevel, 0, 0, false) as Tower;
			type = TowerType;
			_towerCode = TowerCode;
			
			
			var x:Number = Tile.TILESIZE*2;
			var y:Number = 8*Tile.TILESIZE;
			_damageBar = new StatBar(null, x, y, UI.ImgDamage, "Damage");
			this.add(_damageBar);
			y += 0.75 * Tile.TILESIZE;
			_rangeBar = new StatBar(null, x, y, UI.ImgRange, "Range");
			this.add(_rangeBar);
			_lightrangeBar = new StatBar(null, x, y, UI.ImgLightRange, "Range");
			this.add(_lightrangeBar);
			y += 0.75 * Tile.TILESIZE;
			_speedBar = new StatBar(null, x, y, UI.ImgSpeed, "Speed");
			this.add(_speedBar);
			
			// Hide bars at first.  
			_damageBar.visible = false;
			_rangeBar.visible = false;
			_lightrangeBar.visible = false;
			_speedBar.visible = false;
		}
		
		override public function create():void {
			if ((Level.showButtons & _towerCode) > 0) {
				FlxG.state = _nextState;
				return;
			}
			super.create();
			_playbuttonText.text = "[ENTER] Continue";
			Level.showButtons = Level.showButtons | _towerCode;
			addUnlockedTower();
		}
		
		override public function destroy():void {
			super.destroy();
			t = null;
			tmpLevel = null;
			_damageBar = null;
			_rangeBar = null;
			_speedBar = null;
			_lightrangeBar = null;
			_nextState = null;
		}
		private function addUnlockedTower():void {
			var tower:FlxSprite = new FlxSprite(Tile.TILESIZE * 12, 11* Tile.TILESIZE, t._towerImage)
			tower.scale = new FlxPoint(1.5, 1.5);
			this.foregroundImages.add(tower);
			
			var attack:AttackTower = new type(tmpLevel, 0, 0, false) as AttackTower;
			if (attack != null) {
				var sprite:FlxSprite = new FlxSprite(Tile.TILESIZE * 14, 9 * Tile.TILESIZE, attack._attackSpriteImage);
				sprite.scale = new FlxPoint(1.5, 1.5);
				this.foregroundImages.add(sprite); //_attackSpriteImage
			}
			
			addButton(_nextState, grass, t._towerName, true, false);
			
			var titleText:FlxText = new FlxText(0, Tile.TILESIZE, FlxG.width, "New Tower Unlocked");
			titleText.setFormat("diavlo", UI.txtSize(1.5), super._TITLE_COLOR, "center", 0xff000000);
			add(titleText);
			
			var x:Number = Tile.TILESIZE * 6;
			
			var statsTitle:FlxText = new FlxText(Tile.TILESIZE*1, x, FlxG.width, title);
			statsTitle.setFormat("diavlo", UI.txtSize(.75), super._SCORE_COLOR, "left", 0xff000000);
			statsTitle.text = "Tower Stats\n\n\n\n\nSpecial Ability";
			add(statsTitle);			
			
			var abilityTitle:FlxText = new FlxText(Tile.TILESIZE*18.5, x, FlxG.width, title);
			abilityTitle.setFormat("diavlo", UI.txtSize(.75), super._SCORE_COLOR, "left", 0xff000000);
			abilityTitle.text = "Upgrades Into\n\n\n\n\nUpgraded Ability";
			add(abilityTitle);
			
			x += Tile.TILESIZE * 1.5;
			
			var abilityText:FlxText = new FlxText(Tile.TILESIZE, x+5*Tile.TILESIZE, FlxG.width, title);
			abilityText.setFormat("diavlo", UI.txtSize(.5), super._SCORE_COLOR, "left", 0xff000000);
			abilityText.text = t._towerData;
			add(abilityText);

			var upgradeText:FlxText = new FlxText(Tile.TILESIZE*18.5, x, FlxG.width, title);
			upgradeText.setFormat("diavlo", UI.txtSize(.5), super._SCORE_COLOR, "left", 0xff000000);
			upgradeText.text = "Not Able to Upgrade";
			
			var upgradeTower:Tower = new t._upgradesInto(tmpLevel,0,0,false) as Tower;
			if (upgradeTower != null){
				upgradeText.text = upgradeTower._towerName;
			}
			add(upgradeText);
			
			var upgradeAbilityText:FlxText = new FlxText(Tile.TILESIZE*18.5, x+Tile.TILESIZE*5, FlxG.width, title);
			upgradeAbilityText.setFormat("diavlo", UI.txtSize(.5), super._SCORE_COLOR, "left", 0xff000000);
			upgradeAbilityText.text = upgradeTower._towerData;
			add(upgradeAbilityText);
			
			this.foregroundImages.add(new FlxSprite(Tile.TILESIZE * 21, x + 1.5 * Tile.TILESIZE, upgradeTower.towerImage));
		
			if (attack != null) {
				_rangeBar.visible = true;
				_rangeBar.setStars(t._range);	
				_speedBar.setStars(attack._reloadTime);
				_damageBar.setStars(attack._damage);
			} else {
				_lightrangeBar.visible = true;
				_lightrangeBar.setStars(t._range);
				_speedBar.setStars(0);
				_damageBar.setStars(0);
			}
			_speedBar.visible = true;
			_damageBar.visible = true;
			
		}
		override public function nextLevel():void {
			_nextState.nextLevel();
		}
		
		public function get nextState():GameState { return _nextState; }
		
		public function set nextState(value:GameState):void 
		{
			_nextState = value;
		}
	}
}