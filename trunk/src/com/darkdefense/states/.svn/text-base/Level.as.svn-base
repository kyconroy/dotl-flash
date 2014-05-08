package com.darkdefense.states
{
	import com.darkdefense.LevelStats;
	import com.darkdefense.states.worlds.TowerUnlockWorld;
	import com.darkdefense.ui.*;
	import com.darkdefense.enemies.*;
	import com.darkdefense.tiles.*;	
	import com.darkdefense.towers.*;
	import com.darkdefense.PlayerBase;
	import com.darkdefense.Parser;
	
	import org.flixel.data.FlxAnim;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import org.flixel.FlxState;
	import org.flixel.FlxObject;

	import FGReplay.*;
	import com.darkdefense.PlayerStats;
	
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class Level extends GameState
	{
		//protected vars
		protected var _levelSpec:Class; 
		protected var _worldNum:int;
		protected var _levelNum:int;
		protected var _showButton:uint;
		protected var _showUpgrade:Boolean;
		
		//public vars
		public static var showButtons:uint;
		public static var showUpgrade:Boolean;
		
		public var nextState:GameState;
		public var bonusScore:Number;
		public var goalTime:Number;

		
		public var waves:FlxGroup;
		public var waveHead:EnemyWave = null;
		public var waveTail:EnemyWave = null;
		public var messageHead:TutorialPopup = null;
		public var messageTail:TutorialPopup = null;
		public var fog:Fog;
		public const SLOWSPEED:Number = 0.5;
		public const MEDSPEED:Number = 1;
		public const FASTSPEED:Number = 2;
		
		public var parentWorld:World;
        public var canWin:Boolean = true;
		
		// Groups.  
		public var path:FlxGroup;
		public var ltowers:FlxGroup;
		public var lights:FlxGroup;
		public var movingLights:FlxGroup;
		public var atowers:FlxGroup;
		public var enemies:FlxGroup;
		public var otherTiles:FlxGroup;
		public var waterCorners:FlxGroup;
		public var waterEdges:FlxGroup;
		public var unBuildable:FlxGroup;
		public var ui:UI;
		public var enemyHealths:FlxGroup;
		public var towerSelect:FlxGroup;
		public var bonuses:FlxGroup;
		public var tutorialText:FlxGroup;
		
		// Misc.  
		public var playerHealth:int = 40;
		public var active:Boolean;
		public var enemyBase:Array;
		public var playerBase:PlayerBase;
		public var tile:Tile;
		public var waveNum:int = 0;
		public var createdWaves:int = 0;
		public var totalWaveNum:int = 0;
		public var enemyCount:int = 0;
		public var playerWon:Boolean = false;
		public var levelOver:Boolean = false;
		public var waveTimeBonus:int = 10000;
		public var gameScore:int = 0;
		public var BackgroundMusic:Class;
		public var addBonus:Boolean;
		public static var backgroundSprite:FlxGroup;
		public var elapsedTime:Number;
		
		public var enemySpeed:Number   = SLOWSPEED; // Multiplies to affect the speed of enemies.  
		public var buildSpeed:Number   = SLOWSPEED; // Same for building towers.  
		public var upgradeSpeed:Number = SLOWSPEED; // Same for upgrades.  
		public var cheat:Boolean;
		
		// camera
		public var camera:Camera;
		
		//logging
		public var loggingEvents:CapstoneReplay;
		private var _unlockButtons:uint;
		private var _unlockUpgrade:Boolean;
		private var _init:Boolean = false;
		private var _unlockWorld:TowerUnlockWorld;
		
		/* X and Y are where on the screen/canvas the map should go. */
		public function Level(LevelSpec:Class, ParentWorld:World, NextState:GameState, BackgroundMusic:Class = null, UnlockWorld:TowerUnlockWorld = null,
					addBonus:Boolean=true, unlockButtons:uint = 0x00, unlockUpgrade:Boolean=false, Cheat:Boolean = false):void
		{
			super();
			cheat = Cheat;
			_isLevel = true;
			_unlockButtons = unlockButtons;
			_unlockUpgrade = unlockUpgrade;
			
			if (LevelSpec != null) {
				var levelText:String = new LevelSpec;
				var rows:Array = levelText.split("\n");
				for each (var row:String in rows) {
					if (row.charAt(0) == "%") bonusScore = parseFloat(row.substring(1));
				}
			}
			loggingEvents = new CapstoneReplay(PlayerStats.LevelLoggingId);
			this.parentWorld = ParentWorld;
			this.path = new FlxGroup;
			this.atowers = new FlxGroup;
			this.ltowers = new FlxGroup;
			this.lights = new FlxGroup;
			this.movingLights = new FlxGroup;
			this.otherTiles = new FlxGroup;
			this.waterCorners = new FlxGroup;
			this.waterEdges = new FlxGroup;
			this.enemies = new FlxGroup;
			this.waves = new FlxGroup;
			this.unBuildable = new FlxGroup;
			this.enemyHealths = new FlxGroup;
			this.towerSelect = new FlxGroup;
			this.bonuses = new FlxGroup;
			this.tutorialText = new FlxGroup;
			this.enemyBase = new Array;
			this._unlockWorld = UnlockWorld;
			
			this._levelSpec = LevelSpec;
			this.nextState = NextState;
			this.active = true;
			this.addBonus = addBonus;
			this._showButton = showButtons;
			this._showUpgrade = showUpgrade;
			this.elapsedTime = 0;
			this.goalTime = 0;
			this.add(bonuses);
			this.add(tutorialText);
			
			PlayerStats.initSave(fullLevelID + "highscore", 0);
			PlayerStats.initSave(fullLevelID + "medalscore", bonusScore);
			PlayerStats.initSave(fullLevelID + "hasmedal", false);
			PlayerStats.initSave(fullLevelID + "enabled", false);
			
		}
		
		override public function update():void {
			elapsedTime += FlxG.elapsed * buildSpeed;
			if (cheat) {
				ui.timeSinceLastBuild = UI._MAX_BUILD_ENERGY;
				ui.timeSinceLastUpgrade = 100;
			}
			for each (var e:Enemy in enemies.members) {
				if (e != null) e.attackable = false;
			}
			for each (var t:AttackTower in atowers.members) {
				if (t != null) t.inLight = false;
			}
			FlxU.overlap(enemies, lights, Enemy.changeAttackable);
			FlxU.overlap(enemies, movingLights, Enemy.changeAttackable);
			FlxU.overlap(atowers, lights, function(t:AttackTower, l:LightRadius):void {
					if (l.checkDistance(t.center)) t.inLight = true;
				});
			FlxU.overlap(atowers, movingLights, function(t:AttackTower, l:LightRadius):void {
				if (l.checkDistance(t.center)) t.inLight = true;
			});
			FlxU.overlap(enemies, path, Enemy.movementCallback);
			super.update();
			if (fog != null) fog.update();
			if (levelOver && canWin) {
				FlxG.fade.start(0xFF000000, 1, onFade);
			}
			_init = true;
		}
		
		override public function create():void {
			if (BackgroundMusic != null)
				FlxG.playMusic(BackgroundMusic, 0.8);
			Level.showButtons = Level.showButtons | _unlockButtons;
			Level.showUpgrade = Level.showUpgrade || _unlockUpgrade;
			
			// Initialize graphics.  
			fog = new Fog(this.lights, this.movingLights);
			this.add(fog);
			this.ui = new UI(this, Level.showButtons | _unlockButtons, Level.showUpgrade || _unlockUpgrade);	
			if (cheat) this.ui = new UI(this, 0xff, true);
			this.add(ui);
			this.BackgroundMusic = BackgroundMusic;
			backgroundSprite = new TiledBackground();
			
			Parser.parseLevel(this, 0, 0, _levelSpec);
			if (messageHead == null) {
				waveHead.start();
			} else {
				messageHead.start(waveHead);
			}
			loggingEvents.addEvent("StartLevel", this.fullLevelID);
		}
		
		override public function render():void {
			if (!_init) return;
			backgroundSprite.render();
			waterCorners.render();
			waterEdges.render();
			super.render();
			enemyHealths.render();
			fog.render();
			tutorialText.render();
			ui.render();
			bonuses.render();
		}
		
		private function onFade():void {
			if(!playerWon) loggingEvents.addEvent("levelOver", this.fullLevelID +"/Lose/"+gameScore+"/0"); 
			if (playerWon && playerBase.health > 0) {
				if (parentWorld.getNextLevel() == null) {
					FlxG.state = new WinState(this, gameScore, playerBase.health, (Math.floor(elapsedTime)), parentWorld, parentWorld);
				} else if (_unlockWorld != null) {
					_unlockWorld.nextState = new WinState(this, gameScore, playerBase.health, (Math.floor(elapsedTime)), parentWorld.getNextLevel(), parentWorld);
					FlxG.state = _unlockWorld;
					nextState.nextLevel();
				} else {
					FlxG.state = new WinState(this, gameScore, playerBase.health, (Math.floor(elapsedTime)), parentWorld.getNextLevel(), parentWorld);
					nextState.nextLevel();
				}
			} else {
				FlxG.state = new LoseState(freshLevel(), parentWorld);
			}
		}
		public function freshLevel():Level {
			var lvl:Level = new Level(_levelSpec, parentWorld, nextState, BackgroundMusic, _unlockWorld, addBonus, _showButton, _showUpgrade, cheat);
			lvl.worldNum = _worldNum;
			lvl.levelNum = _levelNum;
			return lvl;
		}
		public function set gameSpeed(s:Number):void {
			enemySpeed = buildSpeed = upgradeSpeed = s;
		}
		
		override public function get worldNum():int { return _worldNum; }
		
		override public function set worldNum(value:int):void 
		{
			_worldNum = value;
		}
		
		override public function get levelNum():int { return _levelNum; }
		
		override public function set levelNum(value:int):void 
		{
			_levelNum = value;
		}
		
		public override function get fullLevelID():String {
			return _worldNum + "-" + _levelNum;
		}
		
		override public function destroy():void {
			super.destroy();
			this.fog = null;
			this.ui = null;
			this.BackgroundMusic = null;
			this.playerBase = null;
			this.enemyBase = null;
			backgroundSprite = null;
			waves.destroy();
			waves = null;
			waveHead= null;
			waveTail = null;
			messageHead = null;
			messageTail = null;
			path = null;
			ltowers = null;
			lights = null;
			movingLights = null;
			atowers = null;
			enemies = null;
			otherTiles = null;
			waterCorners = null;
			waterEdges = null;
			unBuildable = null;
			ui = null;
			enemyHealths = null;
			towerSelect = null;
			bonuses = null;
			tutorialText = null;
			parentWorld = null;
		}
	}
}