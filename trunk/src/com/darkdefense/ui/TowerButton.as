package com.darkdefense.ui
{
	import com.darkdefense.logging.TowerGraphState;
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
	
	
	public class TowerButton extends FlxButton
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
		private var _timeRemaining:Number = 0;
		private var _selectedSprite:SelectedTowerSprite;
		private var _backgroundSprite:FlxSprite;
		private var _bonusTime:Number = 0
		private var _selectedItem:Tower;
		private var _x:Number;
		private var _y:Number;
		private var _t:Tower;
		private var b:BonusDisplay;

		
		private const BONUS:int = 5;
		
		[Embed("../../../assets/images/keycap.png")] private var ImgKeycap:Class;
		[Embed("../../../assets/images/tower-button-bg.png")] private var Background:Class;
		
		public function TowerButton(ParentLevel:Level, X:int, Y:int, TowerType:Class, ui:UI)
		{
			super(X, Y, setTower);
			this.scrollFactor = new FlxPoint(0, 0);
			_t = new TowerType(ParentLevel, 0, 0, false) as Tower;
			_t.kill();
			
			_x = X;
			_y = Y;
			_backgroundSprite = new FlxSprite(X - 3, Y - 3, Background);
			_level = ParentLevel;
			selected = false;
			_type = TowerType;
			_ui = ui;
			_key = _t.buildKey;
			_lagTime = _t.time_between_builds;
			var buttonSprite: FlxSprite = new FlxSprite(X, Y, null);
			buttonSprite.loadGraphic(_t.towerImage);
			loadGraphic(buttonSprite, buttonSprite);
			_selectedSprite = new SelectedTowerSprite(X, Y);
			
			on = false;
			// build letter
			var keycap:FlxSprite = new FlxSprite(X + 0.2 * Tile.TILESIZE, Y + 1.1 * Tile.TILESIZE, ImgKeycap);
			keycap.scrollFactor = new FlxPoint(0, 0);
			_ui.add(keycap);
			_buildLetter = new FlxText(X, Y + 1.2 * Tile.TILESIZE, Tile.TILESIZE, _key + " ");
			_buildLetter.scrollFactor = new FlxPoint(0,0);
			_buildLetter.setFormat(null, UI.txtSize(0.25), 0xff000000, "center");		
			_ui.add(_buildLetter);
			
			//clockSprite
			_clock = new ClockSprite(X, Y);
			this.add(_clock);
		}
		
		private function setTower():void
		{
			if (!_level.active) return;
			if (_selectedItem != null) _selectedItem.removeLastItemSelected();
			if (_ui.selectedItem != null) _ui.selectedItem.removeLastItemSelected();
			_ui.selectedItem = null;
			if (_ui.buildCursor != null) {
				_ui.typeSelected = null;
				_ui.buildCursor.kill();
				_ui.remove(_ui.buildCursor, true);
			}
			_ui.buildCursor = new BuildCursor(_level, FlxG.mouse.x, FlxG.mouse.y, _type);
			_ui.typeSelected = _type;
			_ui.buildCursor.fracTimeRemaining = _timeRemaining/_lagTime;

			_ui.energyBar.towerBarHeight = _lagTime;
			_ui.add(_ui.buildCursor);
			_selectedSprite.alpha = 1;
		}
		
		override public function update():void
		{
			_selectedSprite.update();
			if(!_initialized) {
				if(FlxG.stage != null) {
					FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					_initialized = true;
				}
			}

			if (overlapsPoint(FlxG.mouse.x,FlxG.mouse.y))
			{
				hover = true;
				if(!FlxG.mouse.pressed())
					_pressed = false;
				else if(!_pressed)
					_pressed = true;
			}
			else {
				hover = false;
			}
				
			if (FlxG.keys.justReleased(_key)) setTower();
			
			_timeRemaining = FlxU.ceil(_lagTime - _ui.timeSinceLastBuild);
			if (_timeRemaining <= 0){
				if (_timeRemaining < _bonusTime-5 && _level.addBonus) {
					b = new BonusDisplay(_x - (Tile.TILESIZE /4), _y - (Tile.TILESIZE /4), _level, BONUS);
					b.velocity.x = 0;	//(_level.ui.scoreLocation.x - b.x)/3;
					b.velocity.y = (_level.ui.scoreLocation.y - b.y)/3;
					_level.bonuses.add(b);
					_level.gameScore += BONUS;
					_bonusTime = _timeRemaining;
				}
			} else _bonusTime = 0;
			_clock.updateCoolDown(x, y, _timeRemaining);// _lagTime);
			
			if (_ui.typeSelected == _type) {
				if (_ui.buildCursor != null) _ui.buildCursor.fracTimeRemaining = (_timeRemaining);
				if (_ui.inLight && !_ui.onStuff) {
					_ui.buildCursor.canBuildHere = true;
					if (_timeRemaining <= 0 && FlxG.mouse.justReleased()) {
						if (!this.hover) {
							var tx:Number = _ui.buildCursor.x;
							var ty:Number = _ui.buildCursor.y;
							tx -= tx % Tile.TILESIZE;
							ty -= ty % Tile.TILESIZE;
						
							new _type(_level, tx, ty);
							_ui.energyBar.towerBarHeight = 0;
							if (_ui.selectedItem != null) _ui.selectedItem.removeLastItemSelected();
							_ui.selectedItem = null;
							_ui.timeSinceLastBuild -= _lagTime;
							_ui.typeSelected = null;
						}
					}
				} else {
					_ui.buildCursor.canBuildHere = false;
				}
				_selectedSprite.clicked = true;
			} 
			else {
				_selectedSprite.clicked = false;
				/*
				if (hover) {
					if (_ui.selectedItem != null) {
						_selectedItem = _ui.selectedItem;
						_ui.selectedItem.removeLastItemSelected();
					}
					_t.select();
				} else {
					if (_t.isSelected) {
						_t.removeLastItemSelected();
						_t.isSelected = false;
					}
					if (_selectedItem != null) {
						_selectedItem.select();
						_selectedItem = null;
					}
				}*/
			}
			_selectedSprite.hover = hover;
		}
		override public function render():void {
			_backgroundSprite.render();
			if (_selectedSprite.clicked || _selectedSprite.hover) _selectedSprite.render();
			super.render();
		}
	}
}