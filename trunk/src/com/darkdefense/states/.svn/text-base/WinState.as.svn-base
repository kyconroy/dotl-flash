package com.darkdefense.states
{
	import com.darkdefense.LevelStats;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.ui.Fog;
	import org.flixel.*;
	import org.flixel.data.FlxFade;
	import com.darkdefense.PlayerStats;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.*;
	
	/**
	 * ...
	 * @author DarkDefense
	 */
    public class WinState extends GameState
    {
		[Embed(source = '../../../assets/images/dirtpath.png')] private var DirtPath:Class;
		[Embed("../../../assets/images/plus-button.png")] private var PlusButton:Class;
		[Embed("../../../assets/images/minus-button.png")] private var MinusButton:Class;
		private var _nextState:FlxState;
		private var _totalScore:Number;
		private var _thisLevel:Level;
		private var _fog:Fog;
		private static var _lights:FlxGroup;
		private static var _scores:FlxGroup;
		private var _init:Boolean = false;
		private static var _backgroundSprite:FlxGroup;
		private	var txtColor:uint = 0xFFBFFEBF;
		private	var txtFont:String = "diavlo";
        
		private static var _bonuses:FlxGroup;
		private var _spendablePoints:int;
		private static var _damageText:FlxText;
		private static var _rangeText:FlxText;
		private static var _speedText:FlxText;
		private static var _cooldownText:FlxText;
		private static var _spendText:FlxText;
		private static var _resetText:FlxText;
        
		private var _parentWorld:World;
		
		public override function WinState(prevLevel:Level, Score:Number, hp:Number, time:Number, NextState:FlxState, parentWorld:World):void
		{
			_nextState = NextState;
			_thisLevel = prevLevel;
      _parentWorld = parentWorld;
            
      _lights = new FlxGroup;
			_bonuses = new FlxGroup;
            
			var titleColor:uint = 0xffFF9900;
			var txtColor:uint = 0xffFFFFFF;
			var txtFont:String = "diavlo"
			_totalScore = Score;
			var txt:FlxText;
			
			_scores = new FlxGroup;
			
			txt = new FlxText(0, Tile.TILESIZE, FlxG.width, "Congratulations!");
			txt.setFormat(txtFont, UI.txtSize(1.5), titleColor, "center");
			this.add(txt);
			
			txt = new FlxText(0, 3 * Tile.TILESIZE, FlxG.width, "Level Complete");
			txt.setFormat(txtFont, UI.txtSize(1), titleColor, "center");
			this.add(txt);
				
			var width:int = 8 * Tile.TILESIZE;
			var x:int = FlxG.width / 2 - width / 2;
			var y:int = 8 * Tile.TILESIZE;
			var yStep:int = 1 * Tile.TILESIZE;
			
			txt = new FlxText(x, y, width, "Base score:");
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "left", 0xff000000);
			_scores.add(txt);
			
			txt = new FlxText(x, y, width, "" + _totalScore);
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "right", 0xff000000);
			_scores.add(txt);
			
			y += yStep;
			
			var timeUnder:Number = Math.floor(prevLevel.goalTime - time);
			_totalScore += Math.max(timeUnder, 0)*10;
			txt = new FlxText(x, y, width, "Time bonus:");
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "left", 0xff000000);
			_scores.add(txt);
			
			txt = new FlxText(x, y, width, "" + (Math.max(timeUnder, 0)*10));
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "right", 0xff000000);
			_scores.add(txt);
			
			y += yStep;
			
			_totalScore += hp * 10;
			txt = new FlxText(x, y, width, "Health bonus:");
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "left", 0xff000000);
			_scores.add(txt);
			
			txt = new FlxText(x, y, width, "" + hp*10);
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "right", 0xff000000);
			_scores.add(txt);
			
			y += yStep;
			
			txt = new FlxText(x, y, width, "Total:");
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "left", 0xff000000);
			_scores.add(txt);
			
			txt = new FlxText(x, y, width, "" + _totalScore);
			txt.setFormat(txtFont, UI.txtSize(.6), txtColor, "right", 0xff000000);
			_scores.add(txt);
			
			var pointsEarned:int = PlayerStats.MaxUpgradePoints;
			var levelInfo:LevelStats = PlayerStats.getLevelStats(prevLevel.fullLevelID);
			// give an upgrade point when they beat a level the first time
			if (levelInfo.currentScore == 0)
				PlayerStats.MaxUpgradePoints++;
				
			if (_totalScore >= levelInfo.medalScore && !levelInfo.hasMedal){
				PlayerStats.MaxUpgradePoints++;
				while (levelInfo.hasMedal != true) levelInfo.hasMedal = true;
			}
			
			pointsEarned = PlayerStats.MaxUpgradePoints - pointsEarned;
			if (pointsEarned > 0) {
				txt = new FlxText(0, 6 * Tile.TILESIZE, FlxG.width, "You earned " + pointsEarned + " skill point");
				if (pointsEarned > 1) txt.text += "s"
				txt.text += "!";
				txt.setFormat(txtFont, UI.txtSize(0.75), 0xFFFF9900, "center");
				this.add(txt);
			}
			
			var currentScore:Number = Math.max(levelInfo.currentScore, _totalScore);
			//while (levelInfo.currentScore != currentScore) 
			levelInfo.currentScore = currentScore;

			prevLevel.loggingEvents.addEvent("levelOver", _thisLevel.fullLevelID + "/Win/" + _totalScore + "/" + hp); 
            
      var resetButton:FlxButton = new FlxButton(FlxG.width / 2 - 11.5 * Tile.TILESIZE, 17.5 * Tile.TILESIZE, reset );
			resetButton.width = 5 * Tile.TILESIZE;
			resetButton.height = 1 * Tile.TILESIZE;
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, 5 * Tile.TILESIZE, "Reset Skill Points");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			var img:FlxSprite = new FlxSprite();
            
			img.createGraphic(5 * Tile.TILESIZE, resetButton.height, 0xff999999);
			resetButton.loadGraphic(img);
			resetButton.loadText(txt);
			this.add(resetButton);
			
			var _playbutton:FlxButton = new FlxButton(
				FlxG.width / 2 - 3.5 * Tile.TILESIZE,
				17.5 * Tile.TILESIZE,
				flashFadeToNextState);
			_playbutton.width = 7 * Tile.TILESIZE;
			_playbutton.height = Tile.TILESIZE;
			_playbutton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _playbutton.width, "[ENTER] Continue");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_playbutton.width, _playbutton.height, 0xff999999);
			_playbutton.loadText(txt);
			_playbutton.loadGraphic(img);
			this.add(_playbutton);	
            
			var _mapButton:FlxButton = new FlxButton(
				FlxG.width / 2 + 6.5 * Tile.TILESIZE, 
				17.5 * Tile.TILESIZE,
				fadeToMenu);
			_mapButton.width = 5 * Tile.TILESIZE;
			_mapButton.height = Tile.TILESIZE;
			_mapButton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _mapButton.width, "[Q] Back to Menu");
			txt.setFormat("diavlo", UI.txtSize(0.5),0xfffffffff,"center");
			img = new FlxSprite();
			img.createGraphic(_mapButton.width, _mapButton.height, 0xff999999);
			_mapButton.loadText(txt);
			_mapButton.loadGraphic(img);
			this.add(_mapButton);
			
      addBonuses();
		}
		
		public override function create():void {
			super.create();
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.07, null, false, true);
			
			_lights = new FlxGroup;
			var light:LightRadius = new LightRadius(FlxG.width / 2, FlxG.height / 2, 1.25);
			light.fogOffset = new FlxPoint(FlxG.width / 2 - 5.25 * Tile.TILESIZE, FlxG.height / 2 - 5.5 * Tile.TILESIZE);
			_lights.add(light);
			
			_fog = new Fog(_lights);
			_backgroundSprite = new TiledBackground(null, 30, 20);
			var dirtPath:FlxSprite = new FlxSprite(100, 90, DirtPath);
			_backgroundSprite.add(dirtPath);
			_backgroundSprite.add(new Fog(_lights, null));
		}
		
		public override function update():void
		{
			super.update();
			_scores.update();
			_fog.update();
			
			if (FlxG.keys.justPressed("ENTER"))
			{				
				FlxG.flash.start(0xFFFFFFFF, 0.25, fadeToNextState);
			}
			if (FlxG.keys.justPressed("Q")) {
				fadeToMenu();
			}
            _damageText.text = "" + PlayerStats.DamagePoints;
			_rangeText.text = "" + PlayerStats.RangePoints;
			_speedText.text = "" + PlayerStats.SpeedPoints;
			_cooldownText.text = "" + PlayerStats.CooldownPoints;
			_spendText.text = "" + _spendablePoints;
			_init = true;
		}
		
		public override function render():void {
			if (!_init) return;
			_backgroundSprite.render();
			_scores.render();
			_fog.render();
            _bonuses.render();
			super.render();
		}
		
		override public function destroy():void {
			super.destroy();
			_lights = null;
			_fog = null;
			_backgroundSprite = null;
			_scores = null;
		}

        private function fadeToMenu():void {
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xFF000000, 0.5, toMenu);
		}        
		private function flashFadeToNextState():void {
			FlxG.flash.start(0xFFFFFFFF, 0.25, fadeToNextState);
		}
		private function fadeToNextState():void {
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.5,toNextState);
		}
		private function toNextState():void {
			save();
			FlxG.state = _nextState; 
		}
        private function toMenu():void
		{
			save();
			FlxG.state = _parentWorld;
		}
        
		private function addBonuses():void {

			_spendablePoints = PlayerStats.MaxUpgradePoints - PlayerStats.DamagePoints - PlayerStats.RangePoints - PlayerStats.SpeedPoints - PlayerStats.CooldownPoints;
			var button:FlxButton;
			var img:FlxSprite;
			var titleColor:uint = 0xffFF9900;
			var txtColor:uint = 0xffFFFFFF;
			
			var txt:FlxText;
			
			var modButtonWidth:int = 0;
			var textWidth:int = 5 * Tile.TILESIZE - modButtonWidth;
			//var x:int = FlxG.width / 2 - textWidth / 2 - modButtonWidth / 2;
            var x:int = Tile.TILESIZE;
			var y:int = 11 * Tile.TILESIZE;
			txt = new FlxText(x - 0.2 * Tile.TILESIZE, y, FlxG.width, "Maximum " + UpgradeState.MAX_POINTS + " points per type");
			txt.setFormat(txtFont, UI.txtSize(0.5), titleColor, "left", 0xff000000);
			_bonuses.add(txt);
			
			y += 1 * Tile.TILESIZE;
			txt = new FlxText(x, y, textWidth, "Damage:");
			txt.setFormat(txtFont, UI.txtSize(0.5), txtColor, "left", 0xff000000);
			_bonuses.add(txt);
			
			_damageText = new FlxText(x, y, textWidth, "" + PlayerStats.DamagePoints);
			_damageText.setFormat(txtFont, UI.txtSize(0.5), txtColor, "right", 0xff000000);
			_bonuses.add(_damageText);
			
			createAddButton(x, y, "damage");
			createRmButton(x, y, "damage");
			
			y += Tile.TILESIZE;
			txt = new FlxText(x, y, textWidth, "Range:");
			txt.setFormat(txtFont, UI.txtSize(0.5), txtColor, "left", 0xff000000);
			_bonuses.add(txt);
			_rangeText = new FlxText(x, y, textWidth, "" + PlayerStats.RangePoints);
			_rangeText.setFormat(txtFont, UI.txtSize(0.5), txtColor, "right", 0xff000000);
			_bonuses.add(_rangeText);
			
			createAddButton(x, y, "range");
			createRmButton(x, y, "range");
			
			y += Tile.TILESIZE;
			_speedText = new FlxText(x, y, textWidth, "Attack Speed:");
			_speedText.setFormat(txtFont, UI.txtSize(0.5), txtColor, "left", 0xff000000);
			_bonuses.add(_speedText);
			_speedText = new FlxText(x, y, textWidth, "" + PlayerStats.SpeedPoints);
			_speedText.setFormat(txtFont, UI.txtSize(0.5), txtColor, "right", 0xff000000);
			_bonuses.add(_speedText);
			
			createAddButton(x, y, "speed");
			createRmButton(x, y, "speed");
			
			y += Tile.TILESIZE;
			
			txt = new FlxText(x, y, textWidth, "Build Speed:");
			txt.setFormat(txtFont, UI.txtSize(0.5), txtColor, "left", 0xff000000);
			_bonuses.add(txt);
			_cooldownText = new FlxText(x, y, textWidth, "" + PlayerStats.CooldownPoints);
			_cooldownText.setFormat(txtFont, UI.txtSize(0.5), txtColor, "right", 0xff000000);
			_bonuses.add(_cooldownText);
			
			createAddButton(x, y, "cooldown");
			createRmButton(x, y, "cooldown");
            
            txt = new FlxText(Tile.TILESIZE, 16 * Tile.TILESIZE, 11 * Tile.TILESIZE, "Skill Points Remaining:");
			txt.setFormat(txtFont, UI.txtSize(0.5), txtColor, "left", 0xff000000);
			this.add(txt);
			
			_spendText = new FlxText(Tile.TILESIZE*7, 16 * Tile.TILESIZE, 11 * Tile.TILESIZE, "" + _spendablePoints);
			_spendText.setFormat(txtFont, UI.txtSize(0.5), txtColor, "left", 0xff000000);
			this.add(_spendText);
        }
        
        private function createAddButton(X:Number, Y:Number, ButtonType:String):void {
			var button:FlxButton;
			switch(ButtonType) {
				case "damage":
					button = new FlxButton(X + (Tile.TILESIZE * 6), Y + 5, addPointDamage);
					break;
				case "range":
					button = new FlxButton(X + (Tile.TILESIZE * 6), Y + 5, addPointRange);
					break;
				case "cooldown":
					button = new FlxButton(X + (Tile.TILESIZE * 6), Y + 5, addPointCooldown);
					break;
				case "speed":
					button = new FlxButton(X + (Tile.TILESIZE * 6), Y + 5, addPointSpeed);
					break;
				default:
					break;
			}
			button.width = button.height = Tile.TILESIZE / 2;
			var img:FlxSprite = new FlxSprite(0, 0, PlusButton);
			button.loadGraphic(img);
			this.add(button);
		}
		
		private function createRmButton(X:Number, Y:Number, ButtonType:String):void {
			var button:FlxButton;
			switch(ButtonType) {
				case "damage":
					button = new FlxButton(X + (Tile.TILESIZE * 5.25), Y + 5, rmPointDamage);
					break;
				case "range":
					button = new FlxButton(X + (Tile.TILESIZE * 5.25), Y + 5, rmPointRange);
					break;
				case "cooldown":
					button = new FlxButton(X + (Tile.TILESIZE * 5.25), Y + 5, rmPointCooldown);
					break;
				case "speed":
					button = new FlxButton(X + (Tile.TILESIZE * 5.25), Y + 5, rmPointSpeed);
					break;
				default:
					break;
			}
			button.width = button.height = Tile.TILESIZE / 2;
			var img:FlxSprite = new FlxSprite(0, 0, MinusButton);
			button.loadGraphic(img);
			this.add(button);
		}
        
        private function addPointDamage():void
		{
			if (_spendablePoints > 0 && PlayerStats.DamagePoints < UpgradeState.MAX_POINTS){
				PlayerStats.DamagePoints++;
				_spendablePoints--;
			}
		}
		
		private function rmPointDamage():void
		{
			if (PlayerStats.DamagePoints > 0){
				PlayerStats.DamagePoints--;
				_spendablePoints++;
			}
		}
		
		private function addPointRange():void
		{
			if (_spendablePoints > 0 && PlayerStats.RangePoints < UpgradeState.MAX_POINTS){
				PlayerStats.RangePoints++;
				_spendablePoints--;
			}
		}
		
		private function rmPointRange():void
		{
			if (PlayerStats.RangePoints > 0){
				PlayerStats.RangePoints--;
				_spendablePoints++;
			}
		}
		
		private function addPointSpeed():void
		{
			if (_spendablePoints > 0 && PlayerStats.SpeedPoints < UpgradeState.MAX_POINTS){
				PlayerStats.SpeedPoints++;
				_spendablePoints--;
			}
		}
		
		private function rmPointSpeed():void
		{
			if (PlayerStats.SpeedPoints > 0){
				PlayerStats.SpeedPoints--;
				_spendablePoints++;
			}
		}
		
		private function addPointCooldown():void
		{
			if (_spendablePoints > 0 && PlayerStats.CooldownPoints < UpgradeState.MAX_POINTS){
				PlayerStats.CooldownPoints++;
				_spendablePoints--;
			}
		}
		
		private function rmPointCooldown():void
		{
			if (PlayerStats.CooldownPoints > 0){
				PlayerStats.CooldownPoints--;
				_spendablePoints++;
			}
		}
		
		private function reset():void
		{
			PlayerStats.DamagePoints = 0;
			PlayerStats.RangePoints = 0;
			PlayerStats.SpeedPoints = 0;
			PlayerStats.CooldownPoints = 0;
			_spendablePoints = PlayerStats.MaxUpgradePoints;
		}
		
		private function save():void
		{
			var totalScore:Number = 0;
			for each (var l:LevelStats in PlayerStats.LevelInfo) {
				totalScore += l.currentScore;
			}
			var ls:LevelStats = PlayerStats.getLevelStats(_thisLevel.fullLevelID);
			FlxG.kong.API.stats.submit("HighScore", totalScore);
			PlayerStats.saveStats();
			PlayerStats.initSave(_thisLevel.fullLevelID);
			PlayerStats.saveData(_thisLevel.fullLevelID, ls.currentScore);
		}
	}
}