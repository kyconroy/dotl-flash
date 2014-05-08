package com.darkdefense.states 
{
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.ui.*;
	import com.darkdefense.tiles.Tile;
	import org.flixel.*;
	import org.flixel.data.FlxFade;
	
	/**
	 * ...
	 * @author Erik
	 */
	public class LoseState extends FlxState
    {
		[Embed(source = '../../../assets/images/enemypath.png')] private var DirtPath:Class;
		
		private var _nextState:FlxState;
		private var _thisLevel:Level;
		private static var _fog:Fog;
		private static var _lights:FlxGroup;
		private var _init:Boolean;
		private static var _backgroundSprite:FlxGroup;
		
		public override function LoseState(prevLevel:Level, OverWorldState:FlxState):void
		{
			_nextState = OverWorldState;
			_thisLevel = prevLevel;
			var titleColor:uint = 0xffFF9900;
			var txtColor:uint = 0xFFBFFEBF;
			var txtFont:String = "diavlo"
			var txt:FlxText;
			
			txt = new FlxText(0, Tile.TILESIZE, FlxG.width, "Level Failed");
			txt.setFormat(txtFont, UI.txtSize(1.5), titleColor, "center");
			this.add(txt);
			
			var _playbutton:FlxButton = new FlxButton(
				FlxG.width / 2 - 3.5 * Tile.TILESIZE,
				17.5 * Tile.TILESIZE,
				toMenu );
			_playbutton.width = 7 * Tile.TILESIZE;
			_playbutton.height = Tile.TILESIZE;
			_playbutton.scrollFactor = new FlxPoint(0, 0);
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, _playbutton.width, "[ENTER] Return to Menu");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			var img:FlxSprite = new FlxSprite();
			img.createGraphic(_playbutton.width, _playbutton.height, 0xff999999);
			_playbutton.loadText(txt);
			_playbutton.loadGraphic(img);
			this.add(_playbutton);	
			
			var retryButton:FlxButton = 
				new FlxButton(FlxG.width / 2 - 11.5 * Tile.TILESIZE, 
					17.5 * Tile.TILESIZE, 
					replayLevel );
			retryButton.width = 5 * Tile.TILESIZE;
			retryButton.height = 1 * Tile.TILESIZE;
			txt = new FlxText(0, 0.125 * Tile.TILESIZE, 5 * Tile.TILESIZE, "[R] Retry Level");
			txt.setFormat("diavlo", UI.txtSize(0.5), 0xfffffffff, "center");
			img = new FlxSprite();
			img.createGraphic(5 * Tile.TILESIZE, retryButton.height, 0xff999999);
			retryButton.loadGraphic(img);
			retryButton.loadText(txt);
			this.add(retryButton);
		}
		
		override public function create():void {
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
			
			if (FlxG.keys.justPressed("ENTER"))
			{				
				toMenu();
			}
			
			if (FlxG.keys.justPressed("R"))
			{
				replayLevel();
			}
			_init = true;
		}
		
		private function toMenu():void {
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xFF000000, 0.5, toNextState);
		}
		
		private function replayLevel():void { 
			FlxG.fade = new FlxFade();
			FlxG.fade.start(0xFF000000, 0.5, toThisLevel);
		}
		
		public override function render():void {
			if (!_init) return;
			_backgroundSprite.render();
			_fog.render();
			super.render();
		}
		
		override public function destroy():void {
			super.destroy();
			_fog = null;
			_backgroundSprite = null;
			_lights = null;
		}
		private function toNextState():void {
			FlxG.state = _nextState; 
		}
		private function toThisLevel():void {
			FlxG.state = _thisLevel; 
		}
	}
}