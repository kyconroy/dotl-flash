package com.darkdefense.ui
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.data.FlxMouse;
	import org.flixel.FlxU;
	import org.flixel.FlxText;
	import flash.events.MouseEvent;
	import com.darkdefense.towers.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.Level;
	import com.darkdefense.states.OverWorld;
	
	
	public class UpgradeButton extends FlxButton
	{
		public var hover: Boolean;
		public var selected: Boolean;
		private var _type:Class;
		private var _ui:UI;
		private var _key:String;
		private var _level:Level;
		private var _lagTime:Number;
		private var _buildLetter:FlxText;
		private var _clock:ClockSprite;
		private var _currentClock:ClockSprite;
		private var _clockIndex:int = 0;
		private var _savedUpgrades:Array;
		private var _savedUpgradeClocks:Array;
		private var _selectedTowerSprite:SelectedTowerSprite;
		private var _inactiveSelectedTowerSprite:SelectedTowerSprite;
		private const _MAX_SAVED_UPGRADES:int = 3;
		
		[Embed("../../../assets/images/keycap.png")] private var ImgKeycap:Class;
		[Embed("../../../assets/images/upgrade-button-small.png")] private var ImgSmallButton:Class;


		public function UpgradeButton(ParentLevel:Level, X:int, Y:int, TowerType:Class, ui:UI)
		{
			super(X, Y, upgradeTower);
			this.scrollFactor = new FlxPoint(0, 0);
			var txtColor:uint = 0xFFBFFEBF;
			var t:Tower = new TowerType(ParentLevel, 0, 0) as Tower;
			t.kill();
			
			_level = ParentLevel;
			selected = false;
			_type = TowerType;
			_ui = ui;
			_key = t.buildKey;
			_lagTime = t.time_between_builds;
			var buttonSprite: FlxSprite = new FlxSprite(X, Y, null);
			buttonSprite.loadGraphic(t.towerImage);
			buttonSprite.scrollFactor = new FlxPoint(0, 0);
			loadGraphic(buttonSprite, buttonSprite);
			_selectedTowerSprite = new SelectedTowerSprite(X, Y);
			//this.add(_selectedTowerSprite);
			_inactiveSelectedTowerSprite = new SelectedTowerSprite(X, Y, false);
			//this.add(_inactiveSelectedTowerSprite);
			_inactiveSelectedTowerSprite.alpha = 0;
			_selectedTowerSprite.alpha = 0;
			
			on = false;
			// build letter
			var keycap:FlxSprite = new FlxSprite(X + 0.2 * Tile.TILESIZE, Y + 1.1 * Tile.TILESIZE, ImgKeycap);
			keycap.scrollFactor = new FlxPoint(0, 0);
			_ui.add(keycap);
			_buildLetter = new FlxText(X, Y + 1.2 * Tile.TILESIZE, Tile.TILESIZE, _key + " ");
			_buildLetter.scrollFactor = new FlxPoint(0,0);
			_buildLetter.setFormat(null, UI.txtSize(0.25), 0xff000000, "center");		
			_ui.add(_buildLetter);
			
			// saved upgrades
			_savedUpgrades = new Array;
			_savedUpgradeClocks = new Array;
			var bx:Number = x + 0.5 * Tile.TILESIZE;
			var by:Number = y;
			//clockSprite
			_clock = new ClockSprite(X, Y, 30, 30, true);
			_savedUpgrades.push(this);
			_savedUpgradeClocks.push(_clock);
			this.add(_clock);
			_currentClock = _clock;
			_clock.scrollFactor = new FlxPoint(0, 0);
			for (var i:int = 0; i < _MAX_SAVED_UPGRADES; i++) {
				bx += FlxU.floor(0.75 * Tile.TILESIZE);
				var smallButtonSprite:FlxSprite = new FlxSprite(bx, by, ImgSmallButton);
				smallButtonSprite.scrollFactor = new FlxPoint(0, 0);
				_savedUpgrades.push(smallButtonSprite);
				var clockSprite:ClockSprite = new ClockSprite(bx, by, smallButtonSprite.width, smallButtonSprite.height, true);
				clockSprite.updateCoolDown(bx, by, 1);
				clockSprite.scrollFactor = new FlxPoint(0, 0);
				_savedUpgradeClocks.push(clockSprite);
				_ui.add(smallButtonSprite);
				_ui.add(clockSprite);			
			}
		}
		
		private function upgradeTower():void
		{
			var timeRemaining:Number = FlxU.ceil(_lagTime - _ui.timeSinceLastUpgrade);
			if(_ui.selectedItem != null && !_ui.selectedItem.isUpgraded && _ui.typeSelected == null){
				if(_clockIndex > 0){
					if (_ui.selectedItem.upgrade()) {
						if (_clockIndex <= _MAX_SAVED_UPGRADES) {
							var cx:Number = _savedUpgrades[_clockIndex].x;
							var cy:Number = _savedUpgrades[_clockIndex].y;
							(_savedUpgradeClocks[_clockIndex] as ClockSprite).updateCoolDown(cx, cy, 1);
						}
						_clockIndex--;
						_currentClock = _savedUpgradeClocks[_clockIndex] as ClockSprite;
					}
				} else if (_ui.selectedItem != null && !_ui.selectedItem.isUpgraded && timeRemaining <= 0) {
					if (_ui.selectedItem.upgrade()) _ui.timeSinceLastUpgrade = 0;
				}
			} else if (_ui.selectedItem != null && _ui.selectedItem.isUpgraded) {
				_level.ui.showToolTip(_ui.selectedItem.x, _ui.selectedItem.y, "Cannot Upgrade");
			}
		}
		
		override public function update():void
		{
			if(!_initialized) {
				if(FlxG.stage != null) {
					FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					_initialized = true;
				}
			}
			if (overlapsPoint(FlxG.mouse.x,FlxG.mouse.y)) {
				hover = true;
				if(!FlxG.mouse.pressed())
					_pressed = false;
				else if(!_pressed)
					_pressed = true;
			} else {
				hover = false;
			}
			
			if (FlxG.keys.justReleased(_key)) upgradeTower();
			var timeRemaining:Number = FlxU.ceil(_lagTime - _ui.timeSinceLastUpgrade);
			if (_ui.selectedItem != null && _ui.selectedItem.upgradesInto != null && _ui.typeSelected == null) {
				if (_clockIndex > 0 || timeRemaining <= 0) {
					_selectedTowerSprite.alpha = 1;
					_inactiveSelectedTowerSprite.alpha = 0;
				}
				else {
					_selectedTowerSprite.alpha = 0;
					_inactiveSelectedTowerSprite.alpha = 1;
				}
			} else {
				_selectedTowerSprite.alpha = 0;
				_inactiveSelectedTowerSprite.alpha = 0;
			}
			
			if (_clockIndex <= _MAX_SAVED_UPGRADES) {
				var cx:Number = _savedUpgrades[_clockIndex].x;
				var cy:Number = _savedUpgrades[_clockIndex].y;
				_currentClock.updateCoolDown(cx, cy, timeRemaining / _lagTime);
				if (timeRemaining / _lagTime <= -.1) {
					_ui.timeSinceLastUpgrade = 0;
					_clockIndex++;
					_currentClock = _savedUpgradeClocks[_clockIndex] as ClockSprite;
				}
			}
		}
		override public function render():void {
			_inactiveSelectedTowerSprite.render();
			_selectedTowerSprite.render();
			super.render();
		}
	}
}