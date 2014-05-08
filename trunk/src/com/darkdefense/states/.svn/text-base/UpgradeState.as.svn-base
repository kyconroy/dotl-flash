package com.darkdefense.states 
{
	import com.darkdefense.ui.Fog;
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import com.darkdefense.PlayerStats;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.LevelStats;
	import com.darkdefense.ui.*;
	import com.darkdefense.towers.LightRadius;
	import org.flixel.*;
	import org.flixel.data.FlxFade;

	public class UpgradeState extends FlxState
	{
		[Embed(source = '../../../assets/images/dirtpath.png')] private var DirtPath:Class;
		public static const MAX_POINTS:int = 12;
		
		private var _nextState:FlxState;
		private var _spendablePoints:int;
		private static var _backgroundSprite:FlxGroup;
		
		private static var _damageText:FlxText;
		private static var _rangeText:FlxText;
		private static var _speedText:FlxText;
		private static var _cooldownText:FlxText;
		private static var _spendText:FlxText;
		private static var _resetText:FlxText;
		
		private static var _resetImg:FlxSprite;
		private var _init:Boolean = false;
		private static var _fog:Fog;
		private static var _lights:FlxGroup;
		private static var _bonuses:FlxGroup;
		private var _fromMenu:Boolean;
		
		private	var txtColor:uint = 0xFFBFFEBF;
		private	var txtFont:String = "diavlo";
		
		[Embed("../../../assets/images/plus-button.png")] private var PlusButton:Class;
		[Embed("../../../assets/images/minus-button.png")] private var MinusButton:Class;
		
		public override function UpgradeState(NextState:FlxState, FromMenu:Boolean = false):void
		{
			_nextState = NextState;
			_lights = new FlxGroup;
			_bonuses = new FlxGroup;
			_fromMenu = FromMenu;
		}
		
		public override function create():void
		{	
			super.create();
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xff000000, 0.07, null, false, true);
			
			var light:LightRadius = new LightRadius(FlxG.width / 2, FlxG.height / 2, 1.25);
			light.fogOffset = new FlxPoint(FlxG.width / 2 - 5.25 * Tile.TILESIZE, FlxG.height / 2 - 5.5 * Tile.TILESIZE);
			_lights.add(light);
			
			_fog = new Fog(_lights);
			_backgroundSprite = new TiledBackground(null, 30, 20);
			var dirtPath:FlxSprite = new FlxSprite(100, 90, DirtPath);
			_backgroundSprite.add(dirtPath);
			_backgroundSprite.add(new Fog(_lights, null));
			
			_spendablePoints = PlayerStats.MaxUpgradePoints - PlayerStats.DamagePoints - PlayerStats.RangePoints - PlayerStats.SpeedPoints - PlayerStats.CooldownPoints;
			var button:FlxButton;
			var img:FlxSprite;
			var titleColor:uint = 0xffFF9900;
			var txtColor:uint = 0xffFFFFFF;
			
			var txt:FlxText;
			
			txt = new FlxText(0, Tile.TILESIZE, FlxG.width, "Skill Points");
			txt.setFormat(txtFont, UI.txtSize(1.5), titleColor, "center");
			this.add(txt);
			
			txt = new FlxText(0, 3 * Tile.TILESIZE, FlxG.width, "Maximum " + MAX_POINTS + " points per type");
			txt.setFormat(txtFont, UI.txtSize(1), titleColor, "center");
			this.add(txt);
			
			var modButtonWidth:int = 0;
			var textWidth:int = 8 * Tile.TILESIZE - modButtonWidth;
			var x:int = FlxG.width / 2 - textWidth / 2 - modButtonWidth / 2;
			var y:int = 8 * Tile.TILESIZE;
			txt = new FlxText(x, y, textWidth, "Damage:");
			txt.setFormat(txtFont, UI.txtSize(0.6), txtColor, "left", 0xff000000);
			_bonuses.add(txt);
			
			_damageText = new FlxText(x, y, textWidth, "" + PlayerStats.DamagePoints);
			_damageText.setFormat(txtFont, UI.txtSize(0.6), txtColor, "right", 0xff000000);
			_bonuses.add(_damageText);
			
			createAddButton(x, y, "damage");
			createRmButton(x, y, "damage");
			
			y += Tile.TILESIZE;
			txt = new FlxText(x, y, textWidth, "Range:");
			txt.setFormat(txtFont, UI.txtSize(0.6), txtColor, "left", 0xff000000);
			_bonuses.add(txt);
			_rangeText = new FlxText(x, y, textWidth, "" + PlayerStats.RangePoints);
			_rangeText.setFormat(txtFont, UI.txtSize(0.6), txtColor, "right", 0xff000000);
			_bonuses.add(_rangeText);
			
			createAddButton(x, y, "range");
			createRmButton(x, y, "range");
			
			y += Tile.TILESIZE;
			_speedText = new FlxText(x, y, textWidth, "Attack Speed:");
			_speedText.setFormat(txtFont, UI.txtSize(0.6), txtColor, "left", 0xff000000);
			_bonuses.add(_speedText);
			_speedText = new FlxText(x, y, textWidth, "" + PlayerStats.SpeedPoints);
			_speedText.setFormat(txtFont, UI.txtSize(0.6), txtColor, "right", 0xff000000);
			_bonuses.add(_speedText);
			
			createAddButton(x, y, "speed");
			createRmButton(x, y, "speed");
			
			y += Tile.TILESIZE;
			
			txt = new FlxText(x, y, textWidth, "Cost Reduction:");
			txt.setFormat(txtFont, UI.txtSize(0.6), txtColor, "left", 0xff000000);
			_bonuses.add(txt);
			_cooldownText = new FlxText(x, y, textWidth, "" + PlayerStats.CooldownPoints);
			_cooldownText.setFormat(txtFont, UI.txtSize(0.6), txtColor, "right", 0xff000000);
			_bonuses.add(_cooldownText);
			
			createAddButton(x, y, "cooldown");
			createRmButton(x, y, "cooldown");
			
			
			txt = new FlxText((FlxG.width- 11 * Tile.TILESIZE)/2, 16 * Tile.TILESIZE, 11 * Tile.TILESIZE, "Skill Points Remaining:");
			txt.setFormat(txtFont, UI.txtSize(0.75), txtColor, "left", 0xff000000);
			this.add(txt);
			
			_spendText = new FlxText((FlxG.width - 11 * Tile.TILESIZE)/2, 16 * Tile.TILESIZE, 11 * Tile.TILESIZE, "" + _spendablePoints);
			_spendText.setFormat(txtFont, UI.txtSize(0.75), txtColor, "right", 0xff000000);
			this.add(_spendText);
			
			x += 330;
			
			var _playbutton:FlxButton = new FlxButton(
				FlxG.width / 2 - 3.5 * Tile.TILESIZE,
				17.5 * Tile.TILESIZE,
				toMenu);
			_playbutton.width = 7 * Tile.TILESIZE;
			_playbutton.height = Tile.TILESIZE;
			_playbutton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _playbutton.width, "[ENTER] Continue");
			if (_fromMenu) txt.text = "[ENTER] Return to Menu";
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(_playbutton.width, _playbutton.height, 0xff999999);
			_playbutton.loadText(txt);
			_playbutton.loadGraphic(img);
			this.add(_playbutton);	
			
            var resetButton:FlxButton = new FlxButton(FlxG.width / 2 - 11.5 * Tile.TILESIZE, 17.5 * Tile.TILESIZE, 
				reset );
			resetButton.width = 5 * Tile.TILESIZE;
			resetButton.height = 1 * Tile.TILESIZE;
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, 5 * Tile.TILESIZE, "Reset Skill Points");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
            
			img.createGraphic(5 * Tile.TILESIZE, resetButton.height, 0xff999999);
			resetButton.loadGraphic(img);
			resetButton.loadText(txt);
			this.add(resetButton);
		}
		
		private function toMenu():void {
			FlxG.flash.start(0xFFFFFFFF, 0.25, fadeToNextState);
		}
		
		public override function update():void
		{
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				FlxG.fade = new FlxFade();
				FlxG.fade.start(0xFF000000, 0.5, toNextState);
			}
			_damageText.text = "" + PlayerStats.DamagePoints;
			_rangeText.text = "" + PlayerStats.RangePoints;
			_speedText.text = "" + PlayerStats.SpeedPoints;
			_cooldownText.text = "" + PlayerStats.CooldownPoints;
			_spendText.text = "" + _spendablePoints;
			//_resetText.text = "RESET";
			_init = true;
		}
		
		private function createAddButton(X:Number, Y:Number, ButtonType:String):void {
			var button:FlxButton;
			switch(ButtonType) {
				case "damage":
					button = new FlxButton(X + (Tile.TILESIZE * 10), Y + 5, addPointDamage);
					break;
				case "range":
					button = new FlxButton(X + (Tile.TILESIZE * 10), Y + 5, addPointRange);
					break;
				case "cooldown":
					button = new FlxButton(X + (Tile.TILESIZE * 10), Y + 5, addPointCooldown);
					break;
				case "speed":
					button = new FlxButton(X + (Tile.TILESIZE * 10), Y + 5, addPointSpeed);
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
					button = new FlxButton(X + (Tile.TILESIZE * 9.25), Y + 5, rmPointDamage);
					break;
				case "range":
					button = new FlxButton(X + (Tile.TILESIZE * 9.25), Y + 5, rmPointRange);
					break;
				case "cooldown":
					button = new FlxButton(X + (Tile.TILESIZE * 9.25), Y + 5, rmPointCooldown);
					break;
				case "speed":
					button = new FlxButton(X + (Tile.TILESIZE * 9.25), Y + 5, rmPointSpeed);
					break;
				default:
					break;
			}
			button.width = button.height = Tile.TILESIZE / 2;
			var img:FlxSprite = new FlxSprite(0, 0, MinusButton);
			button.loadGraphic(img);
			this.add(button);
		}
		
		public override function render():void {
			if (!_init) return;
			_backgroundSprite.render();
			_bonuses.render();
			_fog.render();
			super.render();
		}
		
		private function addPointDamage():void
		{
			if (_spendablePoints > 0 && PlayerStats.DamagePoints < MAX_POINTS){
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
			if (_spendablePoints > 0 && PlayerStats.RangePoints < MAX_POINTS){
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
			if (_spendablePoints > 0 && PlayerStats.SpeedPoints < MAX_POINTS){
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
			if (_spendablePoints > 0 && PlayerStats.CooldownPoints < MAX_POINTS){
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
		
		override public function destroy():void {
			super.destroy();
			_lights = null;
			_fog = null;
			_backgroundSprite = null;
			_bonuses = null;
			_resetImg = null;
		}
		
		private function toNextState():void {
			FlxG.state = _nextState;
		}
		
		private function fadeToNextState():void 
		{
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xFF000000, 0.5, toNextState)
		}
	}
}