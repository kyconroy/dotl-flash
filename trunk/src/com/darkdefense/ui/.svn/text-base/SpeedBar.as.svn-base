package com.darkdefense.ui 
{
	import com.darkdefense.states.Level;
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	/**
	 * ...
	 * @author ...
	 */
	public class SpeedBar extends FlxGroup
	{
		
		private var _inactiveBG:FlxSprite;
		private var _activeBG:FlxSprite;
		private var _slowtext:FlxText;
		private var _slowimg:FlxSprite;
		private var _slowButton:FlxButton;
		private var _medtext:FlxText;
		private var _medimg:FlxSprite;
		private var _medButton:FlxButton;
		private var _fasttext:FlxText;
		private var _fastimg:FlxSprite;
		private var _fastButton:FlxButton;
		private var _level:Level;
		override public function SpeedBar(ParentLevel:Level, X:Number,Y:Number):void
		{
			super();
			_level = ParentLevel;
			this.x = X;
			this.y = Y;
			this.width = 5 * Tile.TILESIZE;
			this.height = 0.7 * Tile.TILESIZE;
			_slowtext = new FlxText(0, 0.125 * Tile.TILESIZE, 1.5 * Tile.TILESIZE, "[1] slow ");
			_slowtext.setFormat(null, UI.txtSize(0.2),0xff000000,"center");
			_slowimg = new FlxSprite();
			_slowimg.createGraphic(1.5 * Tile.TILESIZE, 0.7 * Tile.TILESIZE);
			_slowButton = new FlxButton(0, 0, setSlow);
			_slowButton.width = 1.5 * Tile.TILESIZE;
			_slowButton.height = 0.7 * Tile.TILESIZE;
			_slowButton.scrollFactor = new FlxPoint(0, 0);
			_slowButton.loadText(_slowtext);
			_slowButton.loadGraphic(_slowimg);
			this.add(_slowButton);
			
			_medtext = new FlxText(0, 0.125 * Tile.TILESIZE, 1.5 * Tile.TILESIZE, "[2] med ");
			_medtext.setFormat(null, UI.txtSize(0.2),0xfffffffff,"center"); 
			_medimg= new FlxSprite();
			_medimg.createGraphic(1.5 * Tile.TILESIZE, 0.7 * Tile.TILESIZE);
			_medButton = new FlxButton(1.75 * Tile.TILESIZE, 0, setMed);
			_medButton.width = 1.5 * Tile.TILESIZE;
			_medButton.height = 0.7 * Tile.TILESIZE;
			_medButton.scrollFactor = new FlxPoint(0, 0);
			_medButton.loadText(_medtext);
			_medButton.loadGraphic(_medimg);
			this.add(_medButton);
			
			_fasttext= new FlxText(0, 0.125 * Tile.TILESIZE, 1.5 * Tile.TILESIZE, "[3] fast ");
			_fasttext.setFormat(null, UI.txtSize(0.2),0xfffffffff,"center");
			_fastimg= new FlxSprite();
			_fastimg.createGraphic(1.5 * Tile.TILESIZE, 0.7 * Tile.TILESIZE);
			_fastButton = new FlxButton(3.5 * Tile.TILESIZE, 0, setFast);
			_fastButton.width = 1.5 * Tile.TILESIZE;
			_fastButton.height = 0.7 * Tile.TILESIZE;
			_fastButton.scrollFactor = new FlxPoint(0, 0);
			_fastButton.loadText(_fasttext);
			_fastButton.loadGraphic(_fastimg);
			this.add(_fastButton);
			unsetIcons();
			_slowimg.fill(0xffffffff);
			_slowtext.color = 0xff000000;
		}
		public function unsetIcons():void {
			_slowimg.fill(0xff999999);
			_medimg.fill(0xff999999);
			_fastimg.fill(0xff999999);
			_slowtext.color = 0xffffffff;
			_medtext.color = 0xffffffff;
			_fasttext.color = 0xffffffff;
		}
		private function setSlow():void {
			_level.gameSpeed = _level.SLOWSPEED;
			_level.ui.konami_code = _level.ui.konamiCodeBuild();
			unsetIcons();
			_slowimg.fill(0xffffffff);
			_slowtext.color = 0xff000000;
		}
		private function setMed():void {
			_level.gameSpeed = _level.MEDSPEED;
			_level.ui.konami_code = _level.ui.konamiCodeBuild();
			unsetIcons();
			_medimg.fill(0xffffffff);
			_medtext.color = 0xff000000;
		}
		private function setFast():void {
			_level.gameSpeed = _level.FASTSPEED;
			_level.ui.konami_code = _level.ui.konamiCodeBuild();
			unsetIcons();
			_fastimg.fill(0xffffffff);
			_fasttext.color = 0xff000000;
		}
		override public function update():void {
			super.update();
			if (FlxG.keys.justReleased("ONE")) setSlow();
			if (FlxG.keys.justReleased("TWO")) setMed();
			if (FlxG.keys.justReleased("THREE")) setFast();
		}
	}
}