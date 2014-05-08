package com.darkdefense.ui
{
	import com.darkdefense.logging.TowerStats;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import org.flixel.data.FlxFade;
	import org.flixel.data.FlxFlash;
	import org.flixel.data.FlxMouse;
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.*;
	import com.darkdefense.towers.*;
	import com.darkdefense.states.*;
	import com.darkdefense.PlayerStats;
	
	public class UI extends FlxGroup
	{
		// Tower Definitions!  
		public static const LIGHTHOUSE_TOWER:uint =  1;
		public static const LANTERN_TOWER   :uint =  2;
		public static const STARBURST_TOWER :uint =  4;
		public static const ARROW_TOWER     :uint =  8;
		public static const MAGIC_TOWER     :uint = 16;
		public static const CANNON_TOWER    :uint = 32;
		public static const _MAX_BUILD_ENERGY:uint = 20;
		
		private var _init:Boolean;
		public var konami_code:Array;
		private const _UPGRADE_COOLDOWN:Number = 20;
		public var buildCursor:BuildCursor;
		public var typeSelected:Class;
		public var inLight:Boolean;
		public var onStuff:Boolean;
		//timer for cooldowns
		public var timeSinceLastBuild:Number;
		public var timeSinceLastUpgrade:Number;
		public var selectedItem:Tower;
		public var heartList:Heart;
		public const TXTCOLOR:uint = 0xffffffff;
		public var selectedNameDisplay:FlxText;
		//public var selectedStatDisplay:FlxText;
		public var unselectedText:String;
		public var enemyX:Number;
		public var enemyY:Number;
		public var scoreLocation:Point;
		public var tooltips:FlxGroup;
        public var buttonX:Number;
        public var buttonY:Number;
        public var buttonDX:Number;
        public var buttonDY:Number;
		public var menuButtonActive:Boolean = false;
		public var attackRadii:FlxGroup;
		public var deselectButton:FlxButton;
		public var energyBar:EnergyBar;
		
		private var _lastCursor:FlxPoint;
		private var _selectedStatDisplay:FlxText;
		private var _scoreDisplay:FlxText;
		private var _menuButton:FlxButton;
		private var _towerButtons:FlxGroup;
		private var _level:Level;
		private var _background:FlxSprite;
		private var _damageBar:StatBar;
		private var _rangeBar:StatBar;
		private var _lightrangeBar:StatBar;
		private var _speedBar:StatBar;
		private var _gameSpeedSelect:SpeedBar;
		private var _tooltipText:FlxText;
		private var _tooltipBackground:FlxSprite;
		private var _tooltipTimer:Number = 0;
        private var _healthDisplayArea:FlxObject;
		
		//private var _smallFont:String;
		//private var _largeFont:String;
		[Embed("../../../assets/images/tooltip-button.png")] private var TooltipBackground:Class;
		[Embed("../../../assets/images/damage.png")] public static var ImgDamage:Class;
		[Embed("../../../assets/images/range.png")] public static var ImgRange:Class;
		[Embed("../../../assets/images/light-range.png")] public static var ImgLightRange:Class;
		[Embed("../../../assets/images/speed.png")] public static var ImgSpeed:Class;
		[Embed("../../../assets/images/sidebar-bg.jpg")] private var ImgBackground:Class;

		public function UI(ParentLevel:Level, 
						   ShowButtons:uint = 0xff, 
						   ShowUpgrade:Boolean = true):void
		{
			super();
			konami_code = konamiCodeBuild();
			
			_level = ParentLevel;
			attackRadii = new FlxGroup;

			_lastCursor = new FlxPoint;
			typeSelected = null;
			timeSinceLastBuild = 5;
			timeSinceLastUpgrade = 0;
			_background = new FlxSprite(20*Tile.TILESIZE, 0);
			_background.width = FlxU.ceil(6.66 * Tile.TILESIZE);
			_background.height = FlxG.height;
			_background.loadGraphic(ImgBackground);
			_background.scrollFactor = new FlxPoint(0, 0);
			tooltips = new FlxGroup;
			this.add(_background);
			
			_level.unBuildable.add(_background);
			
			var x:Number;
			var y:Number;
			// create UI
			x = 20 * Tile.TILESIZE;
			y = 0.25 * Tile.TILESIZE;
			// Score.  
			scoreLocation = new Point(x+6*Tile.TILESIZE, y);
			_scoreDisplay = new FlxText(x, y, 6.66 * Tile.TILESIZE, '');
			_scoreDisplay.setFormat(null, txtSize(0.5), TXTCOLOR, "right");
			_scoreDisplay.scrollFactor = new FlxPoint(0, 0);
			this.add(_scoreDisplay);
			
			y += 0.75 * Tile.TILESIZE;
			// Health.  
			var hx:Number = 20 * Tile.TILESIZE;
			heartList = new Heart(hx, y);
			this.add(heartList);
			var prev:Heart = heartList;
			var current:Heart;
			for (var i:int = 1; 4 * i < _level.playerHealth; i++) {
				current = new Heart(hx + i * heartList.width, y);
				current.next = prev;
				prev = current;
				this.add(current);
			}
			heartList = current;
			if (_level.playerHealth % 4 != 0) heartList.hurt(4 - _level.playerHealth % 4);
			
			_healthDisplayArea = new FlxObject(hx, y, (i * heartList.width), heartList.height);
            this.add(_healthDisplayArea);
            
            y += 0.75 * Tile.TILESIZE;
			
			// Wave.  
			enemyX = x;
			enemyY = y;

			// Buttons. 
			buttonX  = 20.63 * Tile.TILESIZE;
			buttonDX = 1.5 * Tile.TILESIZE;
			buttonDY = 2 * Tile.TILESIZE;
			x = buttonX;
			buttonY = y += buttonDY - 0.25 * Tile.TILESIZE;
			// Row 1
			if ((ShowButtons & LIGHTHOUSE_TOWER) > 0) this.add(new TowerButton(ParentLevel, x, y, LighthouseTower, this));
			x += buttonDX;
			if ((ShowButtons & LANTERN_TOWER) > 0) this.add(new TowerButton(ParentLevel, x, y, LanternTower, this));
			x += buttonDX;
			if ((ShowButtons & STARBURST_TOWER) > 0) this.add (new TowerButton(ParentLevel, x, y, StarburstTower, this));
			//FlxG.log("starburst? " + (ShowButtons & STARBURST_TOWER));
			x += buttonDX;
			energyBar = new EnergyBar(_level, x, y);
			this.add(energyBar);
			
			x = buttonX;
			y += buttonDY;
			// Row 2
			if ((ShowButtons & ARROW_TOWER) > 0) this.add(new TowerButton(ParentLevel, x, y, ArrowTower, this));
			x += buttonDX;
			if ((ShowButtons & MAGIC_TOWER) > 0) this.add(new TowerButton(ParentLevel, x, y, MagicTower, this));
			x += buttonDX;
			if ((ShowButtons & CANNON_TOWER) > 0) this.add(new TowerButton(ParentLevel, x, y, CannonTower, this));
			
			x = buttonX;
			y += buttonDY;
			// Row 3
			if (ShowButtons && ShowUpgrade) this.add(new UpgradeButton(ParentLevel, x, y, UpgradeTower, this));
		
			y += 1.75 * Tile.TILESIZE;
			unselectedText = '';
			selectedNameDisplay = new FlxText(20 * Tile.TILESIZE, y, 6.66 * Tile.TILESIZE, unselectedText);
			selectedNameDisplay.setFormat("diavlo", txtSize(0.5), TXTCOLOR, "center");
			selectedNameDisplay.scrollFactor = new FlxPoint(0,0);
			this.add(selectedNameDisplay);
			y += Tile.TILESIZE;
			var oldx:Number = x;
			x = 20.63 * Tile.TILESIZE;
			_damageBar = new StatBar(this, x, y, ImgDamage, "Damage");
			this.add(_damageBar);
			y += 0.75 * Tile.TILESIZE;
			_rangeBar = new StatBar(this, x, y, ImgRange, "Range");
			this.add(_rangeBar);
			_lightrangeBar = new StatBar(this, x, y, ImgLightRange, "Range");
			this.add(_lightrangeBar);
			y += 0.75 * Tile.TILESIZE;
			_speedBar = new StatBar(this, x, y, ImgSpeed, "Speed");
			this.add(_speedBar);
			// Hide bars at first.  
			_damageBar.visible = false;
			_rangeBar.visible = false;
			_lightrangeBar.visible = false;
			_speedBar.visible = false;

			x = oldx;
			y += Tile.TILESIZE;
			_selectedStatDisplay = new FlxText(x, y, 5 * Tile.TILESIZE, '');
			_selectedStatDisplay.setFormat("diavlo", txtSize(0.5), TXTCOLOR, "left");
			_selectedStatDisplay.scrollFactor = new FlxPoint(0, 0);
			this.add(_selectedStatDisplay);
			x = 20.83 * Tile.TILESIZE;
			y = 16.5 * Tile.TILESIZE;
			this.add(new VolumeBar(_level, x, y));
			y += Tile.TILESIZE;
			_gameSpeedSelect = new SpeedBar(_level, x, y);
			this.add(_gameSpeedSelect);
			y += 1 * Tile.TILESIZE;
			_menuButton = new FlxButton(x, y, onMenuButtonClick);
			_menuButton.width = 5 * Tile.TILESIZE;
			_menuButton.height = Tile.TILESIZE;
			_menuButton.scrollFactor = new FlxPoint(0, 0);
			var txt:FlxText = new FlxText(0, 0.125 * Tile.TILESIZE, _menuButton.width, "[TAB] Menu");
			txt.setFormat("diavlo", txtSize(0.5),0xfffffffff,"center");
			var img:FlxSprite = new FlxSprite();
			img.createGraphic(_menuButton.width, _menuButton.height, 0xff999999);
			_menuButton.loadText(txt);
			_menuButton.loadGraphic(img);
			this.add(_menuButton);
			
			deselectButton = new FlxButton(0, 0, cancelBuild);
			deselectButton.width = 5 * Tile.TILESIZE;
			deselectButton.height = Tile.TILESIZE;
			deselectButton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, deselectButton.width, "[ESC] Cancel Build ");
			txt.setFormat("diavlo", txtSize(0.5),0xfffffffff,"center");
			img = new FlxSprite();
			img.createGraphic(deselectButton.width, deselectButton.height, 0xff999999);
			deselectButton.loadText(txt);
			deselectButton.loadGraphic(img);
			this.add(deselectButton);
			
			_tooltipBackground = new FlxSprite(0, 0);
			_tooltipBackground.loadGraphic(TooltipBackground);
			_tooltipBackground.offset = new FlxPoint(1, 1);
			//_tooltipBackground.createGraphic(3.7 * Tile.TILESIZE, Tile.TILESIZE, 0xffdddddd);
			_tooltipBackground.alpha = 0.8;
			_tooltipBackground.scrollFactor = new FlxPoint(0, 0);
			this.tooltips.add(_tooltipBackground);
			_tooltipBackground.visible = false;
			_tooltipText = new FlxText(0, 0, _tooltipBackground.width, "");
			_tooltipText.setFormat("diavlo", UI.txtSize(0.4), 0xff000000, "center");
			_tooltipText.alpha = 0.8;
			_tooltipText.scrollFactor = new FlxPoint(0, 0);
			this.tooltips.add(_tooltipText);
			_tooltipText.visible = false;
			
		}
		
		override public function update():void {
			super.update();
			tooltips.update();
			
			konamiCodeCheck();
			_scoreDisplay.text = '' + _level.gameScore;
			
			if (!_level.active) return;
			// The following should not be done if the level is inactive!  
			
			var x:Number;
			var y:Number;
			
			inLight = false;
			onStuff = false;
			
			FlxU.overlap(buildCursor, _level.lights, overlapLight);
			FlxU.overlap(buildCursor, _level.movingLights, overlapLight);
			FlxU.overlap(buildCursor, _level.unBuildable, overlapUnbuildable);
			
			
			var p:FlxObject = new FlxObject(FlxG.mouse.cursor.x, FlxG.mouse.cursor.y, 1, 1);
            
            //tooltip for showing player health
            if (_healthDisplayArea.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y)) {
                if (_healthDisplayArea != null && _level.playerBase != null) {
                   this.showToolTip(FlxG.mouse.x - Tile.TILESIZE + FlxG.mouse.cursor.width,
									FlxG.mouse.y + 0.75 * FlxG.mouse.cursor.height, 
									"Current Health: " + (_level.playerBase.health / 4), 0.8);
                }
            }
            
			if (_tooltipTimer < 1) {
				_tooltipTimer = _tooltipTimer + FlxG.elapsed;
				if (buildCursor != null && (_lastCursor.x != buildCursor.x || _lastCursor.y != buildCursor.y) && _tooltipTimer < 0.85) {
					_tooltipTimer = 0.95;
				}
			} else {
				_tooltipBackground.visible = false;
				_tooltipText.visible = false;
			}
			
			timeSinceLastBuild   += _level.buildSpeed   * FlxG.elapsed;
			timeSinceLastUpgrade += _level.upgradeSpeed * FlxG.elapsed;
			
			if (timeSinceLastBuild > _MAX_BUILD_ENERGY) timeSinceLastBuild = _MAX_BUILD_ENERGY;
			
			if (typeSelected != null) {
				deselectButton.visible = true;
				deselectButton.active = true;
			} else {
				deselectButton.visible = false;
				deselectButton.active = false;
			}
			
			if (FlxG.mouse.justReleased())
			{
				//find current tower
				var towers:Array = new Array;
				towers = towers.concat(_level.atowers.members);
				towers = towers.concat(_level.ltowers.members);
				for each (var tower:Tower in towers) 
				{
					if (tower == null || tower.dead) continue;
					
					if (tower.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y))
					{
						FlxU.overlap(tower, _level.lights, 
							function(t:Tower, r:LightRadius):void {
								if (r.checkDistance(t.center))
									getTower(t,r);
							}
						)
						FlxU.overlap(tower, _level.movingLights, 
							function(t2:Tower, w:LightWedge):void {
								if (w.checkDistance(t2.center))
									getTower(t2,w);
							});
					}
				}
			}
			if (FlxG.keys.ESCAPE) {
				cancelBuild();
			}
			
			if (FlxG.keys.justReleased("TAB") && !menuButtonActive) {
				onMenuButtonClick();
			}
			
			if (typeSelected == null && buildCursor != null) {
				buildCursor.kill();
			}
			
			_init = true;
			if (buildCursor != null) {
				_lastCursor.x = buildCursor.x;
				_lastCursor.y = buildCursor.y;
			}
		}
		
		private function cancelBuild():void {
			if (selectedItem != null) selectedItem.removeLastItemSelected();
			energyBar.towerBarHeight = 0;
			selectedItem = null;
			typeSelected = null;
		}
		
		private function getTower(_thisTower:Tower,light:FlxObject):void
		{
			var _lastItem:Tower = selectedItem;
			selectedItem = _thisTower;
			if (_lastItem != null) {
				_lastItem.removeLastItemSelected();
			}
			_thisTower.select();
		}
		
		private function overlapLight(b:BuildCursor, l:LightRadius):void {
			//We are overlapping the light and can build

			//Check that the center of the tower isn't too far away from the center as to mostly be in the fog
			//Squares good, circles bad
			if (l.checkDistance(b.center)) {
				inLight = true;
			}
		}
		
		private function overlapUnbuildable(A:FlxObject, B:FlxObject):void {
			onStuff = true;
		}

		public function showStats(r:Number, d:Number, s:Number, special:String, upgradeSpecial:String = null, light:Boolean = false):void {
			if (s > 0) s = FlxU.floor(5 * (1 / s));
			d = FlxU.floor(d / 2.5);
			if (light) {
				r = FlxU.ceil((5 * (((r * 2) / Tile.TILESIZE) - 1)) / 3);
			} else {
				r = 2 * (((r * 2) / Tile.TILESIZE) - 1);
			}
			_damageBar.visible = true;
			_damageBar.setStars(d);
			if (light) {
				_lightrangeBar.visible = true;
				_lightrangeBar.setStars(r);
			} else {
				_rangeBar.visible = true;
				_rangeBar.setStars(r);	
			}
			_speedBar.visible = true;
			_speedBar.setStars(s);
			_selectedStatDisplay.text = "Special Ability: \n   " + special;
			if (upgradeSpecial) _selectedStatDisplay.text += "\nUpgraded Ability: \n   " + upgradeSpecial;
		}
		public function hideStats():void {
			_damageBar.visible = false;
			_rangeBar.visible = false;
			_lightrangeBar.visible = false;
			_speedBar.visible = false;
			_selectedStatDisplay.text = '';
			
		}
		override public function render():void {
			if (!_init) return;
			attackRadii.render();
			_background.render();
			super.render();
			tooltips.render();
		}
		
		public static function txtSize(FracTileSize:Number):Number {
			var size:Number = 1.0 * FracTileSize * Tile.TILESIZE;
			return FlxU.ceil(size/4) * 4;
		}
		
		private function onMenuButtonClick():void
		{
			if (!menuButtonActive) this.add(new Menu(_level));
			//FlxG.fade.start(0xff000000, 0.15, function():void { FlxG.state = _level.overWorld; } )
		}
		
		public function konamiCodeBuild():Array {
			return new Array("UP", "UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A", "ENTER");
		}
		
		private function konamiCodeCheck():void {
			if (konami_code.length == 0) {
				if (_level.enemySpeed != 0) {
					_level.gameSpeed = 4;
					_gameSpeedSelect.unsetIcons();
				}
			} else if (FlxG.keys.justPressed(konami_code[0])) {
				konami_code.shift();
			}
		}
		
		public function showToolTip(X:Number, Y:Number, tip:String, time:Number = 0):void {
			_tooltipText.text = tip;
			_tooltipTimer = time;
			_tooltipBackground.x = X + Tile.TILESIZE;
			_tooltipBackground.y = Y;
			_tooltipText.x = X + 0.9 * Tile.TILESIZE;
			_tooltipText.y = Y + 0.18 * Tile.TILESIZE;
			_tooltipBackground.visible = true;
			_tooltipText.visible = true;
		}
		
	}
}