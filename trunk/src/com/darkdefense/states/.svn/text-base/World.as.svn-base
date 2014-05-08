package com.darkdefense.states 
{
	import com.darkdefense.states.worlds.PlaysStatsWorld;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.ui.ButtonCallback;
	import com.darkdefense.ui.Fog;
	import com.darkdefense.ui.VolumeBar;
	import flash.media.Sound;
	import org.flixel.*;
	import com.darkdefense.states.Level;
	import com.darkdefense.PlayerStats;
	import com.darkdefense.LevelStats;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.UI;
	import com.darkdefense.ui.TiledBackground;
	import org.flixel.data.FlxFade;
	
	public class World extends GameState
	{	
		[Embed(source = '../../../assets/sounds/change.mp3')] private var ChangeNoise:Class;
		[Embed(source = '../../../assets/images/buttonbg.png')] private var ButtonBG:Class;
		[Embed(source = '../../../assets/images/dirtpath.png')] private var DirtPath:Class;
		public static var fog:Fog;
		
		private const _SCROLL_DELAY:Number = 0.5; // Seconds.  
		private const _PRESS_DELAY:Number = 0.1; // Also seconds.  
		private const _SCORE_TEXT:String = "Score: ";
		private const _GOAL_TEXT:String = "Goal Score: ";
		protected const _SCORE_COLOR:uint = 0xffFFFFFF;
		private const _GOAL_COLOR:uint  = 0xffFF9900;
		protected const _TITLE_COLOR:uint = 0xffFF9900;
		
		private var _nextLevel:Boolean = false;
		private var _init:Boolean = false;
		private var _changedLevel:Boolean = false;
		private var _pressedFor:Number = 0;
		private var _timeSinceLastPress:Number = 0;
		private var _canPress:Boolean = true;
		private var _buttonWidth:int = 5 * Tile.TILESIZE;
		private var _buttonHeight:int = 5 * Tile.TILESIZE;
		private var _buttonStepX:int = 0.8 * _buttonWidth;
		private var _startX:int = (FlxG.width - _buttonWidth) / 2;
		private var _startY:int = (FlxG.height - _buttonHeight) / 2;
		private var _buttons:FlxGroup;
		private var _lastSelectedLevel:int = 0;
		private var _maxLevels:int;
		private var _lButton:FlxButton;
		private var _rButton:FlxButton;
		private var _upgradeButton:FlxButton;
		private var _loaded:Boolean = false;
		
		protected static var _backgroundSprite:FlxGroup;
		protected var _selectedLevel:int = 0;
		protected var _music:Class;
		protected var _parent:World;
		protected var _bx:Number;
		protected var _by:Number;
		protected var _worldNum:int;
		protected var _lights:FlxGroup;
		protected var _buttonShadows:FlxGroup;
		protected var _mapButton:FlxButton;
		protected var _levels:Array;
		protected var _levelButtons:Array;
		protected var _baseScoreText:FlxText;
		protected var _scoreText:FlxText;
		protected var _baseGoalText:FlxText;
		protected var _goalText:FlxText;
		protected var _playbutton:FlxButton;
		protected var _playbuttonText:FlxText;
		protected var _volBar:VolumeBar;
		protected var _hideButtons:Boolean;
		protected var _fog:Fog;
		
		public var foregroundImages:FlxGroup;
		
		override public function World(ParentWorld:World = null, Music:Class = null, Title:String = "", HideButtons:Boolean = false):void
		{
			super();
			_music = Music;
			_parent = ParentWorld;
			_hideButtons = HideButtons;
			title = Title;
		}
		
		override public function create():void {
			super.create();
			
			PlayerStats.saveStats();
			_volBar = new VolumeBar;
			this.add(_volBar);
			foregroundImages = new FlxGroup();
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.07, null, false, true);
			_init = false;
			_bx = _startX;
			_by = _startY;
			_levels = new Array();
			_levelButtons = new Array();
			_maxLevels = 0;
			_buttons = new FlxGroup();
			_lights = new FlxGroup();
			_buttonShadows = new FlxGroup();
			var light:LightRadius = new LightRadius(_startX, _startY, 1.25);
			light.fogOffset = new FlxPoint(_startX - (_buttonWidth + 0.5 * Tile.TILESIZE)/ 2, _startY - (_buttonHeight + Tile.TILESIZE)/ 2);
			_lights.add(light);
			_backgroundSprite = new TiledBackground(null, 30, 20);
			var dirtPath:FlxSprite = new FlxSprite(100, 90, DirtPath);
			_backgroundSprite.add(dirtPath);
			_fog = new Fog(_lights, null);
			_backgroundSprite.add(_fog);
			
			if (fog == null) fog = new Fog(_lights);
			fog.alpha = 0.5;
			
			if(_music != null) FlxG.playMusic(_music, 0.8);

			var titleText:FlxText = new FlxText(0, Tile.TILESIZE, FlxG.width, title);
			titleText.setFormat("diavlo", UI.txtSize(1.5), _TITLE_COLOR, "center", 0xff000000);
			add(titleText);
			
			_mapButton = new FlxButton(
				FlxG.width / 2 + 6.5 * Tile.TILESIZE, 
				17.5 * Tile.TILESIZE,
				fadeToMap);
			_mapButton.width = 5 * Tile.TILESIZE;
			_mapButton.height = Tile.TILESIZE;
			_mapButton.scrollFactor = new FlxPoint(0, 0);
			var txt:FlxText = new FlxText(0, 0.125 * Tile.TILESIZE, _mapButton.width, "[Q] Back");
			txt.setFormat("diavlo", UI.txtSize(0.5),0xfffffffff,"center");
			var img:FlxSprite = new FlxSprite();
			img.createGraphic(_mapButton.width, _mapButton.height, 0xff999999);
			_mapButton.loadText(txt);
			_mapButton.loadGraphic(img);
			
			if (_parent != null) this.add(_mapButton);

			_playbutton = new FlxButton(
				FlxG.width / 2 - 3.5 * Tile.TILESIZE,
				15.5 * Tile.TILESIZE,
				loadLevel);
			_playbutton.width = 7 * Tile.TILESIZE;
			_playbutton.height = Tile.TILESIZE;
			_playbutton.scrollFactor = new FlxPoint(0, 0);
			_playbuttonText = txt = new FlxText(0, 0.125 * Tile.TILESIZE, _playbutton.width, "[ENTER] Play");
			if (_hideButtons) _playbutton.y += 2 * Tile.TILESIZE;
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_playbutton.width, _playbutton.height, 0xff999999);
			_playbutton.loadText(txt);
			_playbutton.loadGraphic(img);
			this.add(_playbutton);
			
			shadowButton = new FlxButton(_playbutton.x, _playbutton.y, nop );
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _playbutton.width, "[ENTER] Play");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_playbutton.width, _playbutton.height, 0xff999999);
			shadowButton.loadText(txt);
			shadowButton.loadGraphic(img);
			_buttonShadows.add(shadowButton);
			
			_lButton = new FlxButton(
				FlxG.width / 2 - 11.5 * Tile.TILESIZE,
				7 * Tile.TILESIZE,
				lButtonClick);
			_lButton.width = 5 * Tile.TILESIZE;
			
			_lButton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 8.625 * Tile.TILESIZE, _lButton.width, "[LEFT] Previous");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite(0, 8.5 * Tile.TILESIZE);
			img.createGraphic(_lButton.width, Tile.TILESIZE, 0xff999999);
			_lButton.loadText(txt);
			_lButton.loadGraphic(img);
			_lButton.height = 9.5 * Tile.TILESIZE; // Height needs to be re-defined after the loadgraphic.  
			
			var shadowButton:FlxButton;
			// Left shadow button!
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _lButton.width, "[LEFT] Previous");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_lButton.width, Tile.TILESIZE, 0xff999999);
			shadowButton = new FlxButton(_lButton.x, _lButton.y + _lButton.height - Tile.TILESIZE, nop);
			shadowButton.loadText(txt);
			shadowButton.loadGraphic(img);
			_buttonShadows.add(shadowButton);
			
			this.add(_lButton);
			
			_rButton = new FlxButton(
				FlxG.width / 2 + 6.5 * Tile.TILESIZE,
				7 * Tile.TILESIZE,
				rButtonClick);
			_rButton.width = 5 * Tile.TILESIZE;
			_rButton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 8.625 * Tile.TILESIZE, _rButton.width, "[RIGHT] Next");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite(0, 8.5 * Tile.TILESIZE);
			img.createGraphic(_rButton.width, Tile.TILESIZE, 0xff999999);
			_rButton.loadText(txt);
			_rButton.loadGraphic(img);
			_rButton.height = 9.5 * Tile.TILESIZE;
			
			// Right shadow button!
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _rButton.width, "[RIGHT] Next");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_rButton.width, Tile.TILESIZE, 0xff999999);
			shadowButton = new FlxButton(_rButton.x, _rButton.y + _rButton.height - Tile.TILESIZE, nop);
			shadowButton.loadText(txt);
			shadowButton.loadGraphic(img);
			_buttonShadows.add(shadowButton);
			
			this.add(_rButton);
			
			
			var current:FlxState = this;
			_upgradeButton = new FlxButton(_lButton.x, _lButton.y + _lButton.height + 1 * Tile.TILESIZE, fadeToUpgrade);
			_upgradeButton.width = _lButton.width;
			_upgradeButton.height = 1 * Tile.TILESIZE;
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _lButton.width, "[TAB] Skill Points");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_lButton.width, _upgradeButton.height, 0xff999999);
			_upgradeButton.loadGraphic(img);
			_upgradeButton.loadText(txt);
			this.add(_upgradeButton);
			
			_baseScoreText = new FlxText(_playbutton.x, _playbutton.y + 1.2 * Tile.TILESIZE, _playbutton.width, _SCORE_TEXT);
			_baseScoreText.setFormat("diavlo", UI.txtSize(0.5), _SCORE_COLOR, "left");
			this.add(_baseScoreText);
			
			_scoreText = new FlxText(_playbutton.x, _playbutton.y + 1.2 * Tile.TILESIZE, _playbutton.width, "0");
			_scoreText.setFormat("diavlo", UI.txtSize(0.5), _SCORE_COLOR, "right");
			this.add(_scoreText);
			
			_baseGoalText = new FlxText(_playbutton.x, _playbutton.y + 1.8 * Tile.TILESIZE, _playbutton.width, _GOAL_TEXT);
			_baseGoalText.setFormat("diavlo", UI.txtSize(0.5), _GOAL_COLOR, "left");
			this.add(_baseGoalText);
			
			_goalText = new FlxText(_playbutton.x, _playbutton.y + 1.8 * Tile.TILESIZE, _playbutton.width, "0");
			_goalText.setFormat("diavlo", UI.txtSize(0.5), _GOAL_COLOR, "right");
			this.add(_goalText);
			
			var lvl:GameState = (_levels[_selectedLevel] as GameState)

			if (lvl) var stat:LevelStats = PlayerStats.getLevelStats(lvl.worldNum + "-" + lvl.levelNum);
			if (lvl) _scoreText.text = "" + stat.currentScore;
			else	  _scoreText.text = "0";
			if (lvl) _goalText.text = "" + stat.medalScore;
			else	  _goalText.text = "0";
			if ((stat != null) && (stat.currentScore > stat.medalScore)) stat.hasMedal = true;

			if ((null != _levels[_selectedLevel] && !_levels[_selectedLevel] is Level) ||
				 (_levels[_selectedLevel] is Level && (_levels[_selectedLevel] as Level).isLevel)) {
				_baseGoalText.visible = false;
				_baseScoreText.visible = false;
				_goalText.visible = false;
				_scoreText.visible = false;				
			}
		}

		private function fadeToUpgrade():void {
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.5, toUpgrade);
		}
		
		private function toUpgrade():void {
			var upgradeState:UpgradeState = new UpgradeState(this, true);
			FlxG.state = upgradeState; 
		}
		
		private function fadeToMap():void {
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.5, toMap);
		}
		
		private function toMap():void {
			FlxG.state = _parent;
		}
		
		private function nop():void {
			return;
		}
		
		private function toSelectedLevel():void {
			FlxG.state = _levels[_selectedLevel]; 
		}
		
		override public function update():void {
			super.update();
			_buttonShadows.update();
			_buttons.update();
			if (_hideButtons && !_init) {
				_lButton.visible = false;
				_lButton.active = false;
				_rButton.visible = false;
				_rButton.active = false;
				_mapButton.visible = false;
				_mapButton.active = false;
				_upgradeButton.visible = false;
				_upgradeButton.active = false;
			}
			if (FlxG.keys.justPressed("Q") && _parent != null && _mapButton.active) {
				fadeToMap();
			}
			if (_levelButtons.length == 0) {
				_init = true;
				return;
			}
			if (_selectedLevel < 0) _selectedLevel = 0;
			if (_selectedLevel >= _maxLevels) _selectedLevel = _maxLevels - 1;
			_lastSelectedLevel = _selectedLevel;
			_lButton.visible = true;
			_rButton.visible = true;
			if (_selectedLevel == 0) {
				_lButton.visible = false;
			}
			if (_selectedLevel == _maxLevels - 1) {
				_rButton.visible = false;
			}
			if (_levelButtons[_selectedLevel] != null) 
				(_levelButtons[_selectedLevel] as FlxButton).active = false;
			if (FlxG.keys.justPressed("TAB") && !_hideButtons) {
				fadeToUpgrade();
			}
			if (!_canPress) {
				_timeSinceLastPress += FlxG.elapsed;
				if (_timeSinceLastPress > _PRESS_DELAY) _canPress = true;
			}
			if (FlxG.keys.justPressed("RIGHT")) {
				_pressedFor = 0;
				if (_canPress) _selectedLevel++;
			}
			if (FlxG.keys.justPressed("LEFT")) {
				_pressedFor = 0;
				if (_canPress) _selectedLevel--;
			}
			if (FlxG.keys.pressed("RIGHT")) {
				_pressedFor += FlxG.elapsed;
				if (_pressedFor > _SCROLL_DELAY) {
					_selectedLevel++;
					_pressedFor = 0;
				}
			} else if (FlxG.keys.pressed("LEFT")) {
				_pressedFor += FlxG.elapsed;
				if (_pressedFor > _SCROLL_DELAY) {
					_selectedLevel--;
					_pressedFor = 0;
				}
			} else {
				_pressedFor = 0;
			}
			
			// Select next level.  
			if (_selectedLevel < 0) _selectedLevel = 0;
			if (_selectedLevel >= _maxLevels) _selectedLevel = _maxLevels - 1;
			// Post level selection code.  (Enabling buttons, etc, etc.)  
			
			var lvl:GameState = (_levels[_selectedLevel] as GameState);
			var stat:LevelStats = PlayerStats.getLevelStats(lvl.worldNum + "-" + lvl.levelNum);
			if ((stat != null) && (stat.currentScore > stat.medalScore)) stat.hasMedal = true;
			
			var desiredX:Number = - 1 * ((_buttonStepX + _buttonWidth)* _selectedLevel);
			_buttons.velocity.x = 4 * (desiredX - _buttons.x);
			if (_lastSelectedLevel != _selectedLevel || _changedLevel) {	
				FlxG.play(ChangeNoise);
				if (_changedLevel) _changedLevel = false;
				_scoreText.text = "" + stat.currentScore;
				_goalText.text = "" + stat.medalScore;
			}
			if (_levels[_selectedLevel] != null && _levels[_selectedLevel] is Level && 
			   (_levels[_selectedLevel] as Level).isLevel) {
				_baseGoalText.visible = true;
				_baseScoreText.visible = true;
				_goalText.visible = true;
				_scoreText.visible = true;
			} else {
				_baseGoalText.visible = false;
				_baseScoreText.visible = false;
				_goalText.visible = false;
				_scoreText.visible = false;
			}
			for each (var b:FlxButton in _levelButtons) {
				b.active = false;
			}
			var currentButton:FlxButton = (_levelButtons[_selectedLevel] as FlxButton);
			
			lvl = _levels[_selectedLevel];
			stat = PlayerStats.getLevelStats(lvl.worldNum + "-" + lvl.levelNum);
			if (currentButton.overlapsPoint(FlxG.width / 2, FlxG.height / 2) && stat.enabled) {
				currentButton.active = true;
			}
			_playbutton.active  = stat.enabled;
			_playbutton.visible = stat.enabled;
			if (FlxG.keys.justPressed("ENTER") && stat.enabled) {
				loadLevel();
			}
			if (FlxG.keys.justPressed("HOME")) {
				_selectedLevel = 0;
				_changedLevel = true;
			}
			if (FlxG.keys.justPressed("END")) {
				_selectedLevel = 0;
				for (var i:int = 1; i <= _maxLevels; i++) {
					stat = PlayerStats.getLevelStats(_worldNum + "-" + i);
					if (stat.enabled) _selectedLevel = i - 1;
				}
				_changedLevel = true;
			}
			if (!_init) {
				if (!_loaded) {
					_selectedLevel = 0;
					for (i = 1; i <= _maxLevels; i++) {
						stat = PlayerStats.getLevelStats(_worldNum + "-" + i);
						if (stat.enabled) _selectedLevel = i - 1;
					}
					_loaded = true;
				}
				stat = PlayerStats.getLevelStats(_worldNum + "-" + (_selectedLevel + 1));
				_scoreText.text = "" + stat.currentScore;
				_goalText.text = "" + stat.medalScore;
				
			}
			_init = true;
		}
		
		override public function render():void {
			if (!_init) return;
			_backgroundSprite.render();
			if (!_hideButtons) _buttonShadows.render();
			_buttons.render();
			fog.render();
			foregroundImages.render();
			super.render();
		}
		
		// If "Enable" is set, the level is enabled, otherwise it uses the value inside of PlayerStats.  
		public function addButton(NextState:GameState, Icon:Class = null, Name:String = null, Enable:Boolean = false, SetName:Boolean = true):void {
			_maxLevels++;
			if (_maxLevels == 1 && NextState is Level) {
			  if ((NextState as Level).isLevel){
				_baseGoalText.visible = true;
				_baseScoreText.visible = true;
				_goalText.visible = true;
				_scoreText.visible = true;
			  }
			}
			NextState.worldNum = _worldNum;
			NextState.levelNum = _maxLevels;
			var levelId:String = "" + NextState.worldNum + "-" + NextState.levelNum;
			var stat:LevelStats = PlayerStats.getLevelStats(levelId);
			if ((stat != null) && (stat.currentScore > stat.medalScore)) stat.hasMedal = true;
			if (Enable || _maxLevels == 1) {
				if (!stat.enabled) PlayerStats.UnlockedLevels += "" + levelId + "|";
				stat.enabled = true;
			}
			if (SetName) NextState.title = Name;
			if (NextState is Level) {
				stat.medalScore = (NextState as Level).bonusScore;
				if (_maxLevels == 1) _goalText.text = "" + stat.medalScore;
			}
			_levels.push(NextState);
			var bg:FlxSprite = new FlxSprite(_bx - 20, _by - 20, ButtonBG);
			_buttons.add(bg);
			var button:FlxButton = new FlxButton(_bx, _by - 1.3 * Tile.TILESIZE, loadLevel);
			_levelButtons.push(button);
			var img:FlxSprite = new FlxSprite(0, 1.3 * Tile.TILESIZE, Icon);
			if (Icon == null) img.createGraphic(_buttonWidth, _buttonHeight, 0xff000000);
			button.loadGraphic(img);
			if (Name != null) { 
				var txt:FlxText = new FlxText(0, 0, _buttonWidth, Name);
				txt.setFormat("diavlo", UI.txtSize(0.5), 0xffffffff, "center", 0xff000000);
				button.loadText(txt);
			}
			button.height += 1.3 * Tile.TILESIZE;
			_buttons.add(button);
			if (!stat.enabled) {
				var disabledSprite:FlxSprite = new FlxSprite(_bx, _by);
				disabledSprite.createGraphic(_buttonWidth, _buttonHeight, 0xff000000);
				disabledSprite.alpha = 0.85;
				_buttons.add(disabledSprite);
				txt.color = 0xff666666;
			}
			_bx += _buttonWidth + _buttonStepX;
			if (NextState.fullLevelID != null)
			{
				PlayerStats.getLevelStats(NextState.fullLevelID);
			}
		}
		
		override public function get worldNum():int { return 0; }
		override public function get levelNum():int { return _worldNum; }
		
		override public function set worldNum(value:int):void { ; }
		override public function set levelNum(value:int):void { _worldNum = value; }
		
		public function get parentWorld():World { return _parent; }
		
		public function set parentWorld(value:World):void 
		{
			_parent = value;
		}
		
		override public function nextLevel():void {
			_selectedLevel++;
			if (_selectedLevel < _levels.length) {
				var gs:GameState = (_levels[_selectedLevel] as GameState);
				var levelId:String = gs.worldNum + "-" + gs.levelNum;
				var stat:LevelStats = PlayerStats.getLevelStats(levelId);
				if ((stat != null) && (stat.currentScore > stat.medalScore)) stat.hasMedal = true;
				if (!stat.enabled) PlayerStats.UnlockedLevels += "" + levelId + "|";
				stat.enabled = true;
			} else {
				parentWorld.nextLevel();
			}
		}
		
		public function getCurrentLevel():GameState {
			return _levels[_selectedLevel] as GameState;
		}
		
		public function getNextLevel():GameState { 
			var temp:GameState = _parent;
			if ((_selectedLevel + 1) < _levels.length) {
				temp = _levels[_selectedLevel + 1]
			} else if (_parent != null) {
				temp = _parent.getNextLevel();
			} else {
				temp = null;
			}
			return temp;
		}
		
		private function loadLevel():void {
			if (_selectedLevel < 0) return;
			var desiredX:Number = - 1 * ((_buttonStepX + _buttonWidth) * _selectedLevel);
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.5, toSelectedLevel);
		}
		private function lButtonClick():void {
			if (_selectedLevel > 0) {
				_levelButtons[_selectedLevel].active = false;
				_changedLevel = true;
				_selectedLevel--;
			}
		}
		private function rButtonClick():void {
			if (_selectedLevel < _maxLevels) {
				_levelButtons[_selectedLevel].active = false;
				_changedLevel = true;
				_selectedLevel++;
			}
		}
		
		override public function destroy():void {
			super.destroy();
			
			PlayerStats.saveStats();
			if (_buttonShadows != null) _buttonShadows.kill();
			if (_buttons != null) _buttons.kill();
			if (fog != null) fog.kill();
			if (_backgroundSprite != null) {
				_backgroundSprite.destroy();
				_backgroundSprite = null;
			}
			while (_buttons != null &&_buttons.members.length > 0) {
				var b:FlxObject = _buttons.members.pop();
				b.destroy();
			}
			if (_buttons != null) _buttons.destroy();
			_buttons = null;
			if (_lButton != null) _lButton.destroy();
			_lButton = null;
			if (_rButton != null) _rButton.destroy();
			_rButton = null;
			_music = null;
			if (_lights != null) _lights.destroy();
			_lights = null;
			if (_buttonShadows != null) _buttonShadows.destroy();
			_buttonShadows = null;
			if (_mapButton != null) _mapButton.destroy();
			_mapButton = null;
			if (_levelButtons != null) for each (var lb:FlxButton in _levelButtons) if (lb != null) lb.destroy();
			while ((_levelButtons != null) && (_levelButtons.length > 0)) _levelButtons.pop();
			_levelButtons = null;
			_baseScoreText = null;
			_scoreText = null;
			_baseGoalText = null;
			_goalText = null;
			_playbutton = null;
			_playbuttonText = null;
			_volBar = null;
			foregroundImages = null;
			var remList:Array = defaultGroup.members;
			for each (var o:FlxObject in remList) {
				defaultGroup.remove(o, true);
			}
		}
		
	} // End Class
}