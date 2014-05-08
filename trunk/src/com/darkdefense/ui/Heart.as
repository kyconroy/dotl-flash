package com.darkdefense.ui
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.Level;
	
	public class Heart extends FlxSprite
	{
		[Embed("../../../assets/images/heart100.png")] private var Heart100:Class;
		[Embed("../../../assets/images/heart075.png")] private var Heart075:Class;
		[Embed("../../../assets/images/heart050.png")] private var Heart050:Class;
		[Embed("../../../assets/images/heart025.png")] private var Heart025:Class;
		[Embed("../../../assets/images/heart000.png")] private var Heart000:Class;
		
		private var _heart100:FlxSprite;
		private var _heart075:FlxSprite;
		private var _heart050:FlxSprite;
		private var _heart025:FlxSprite;
		private var _heart000:FlxSprite;
		private var _currentSprite:FlxSprite;
		private var _level:Level;
		
		public var next:Heart;
		public function Heart(X:Number, Y:Number) 
		{
			super();
			this.health = 4;
			this.x = X;
			this.y = Y;
			this.width = this.height = FlxU.ceil(0.66 * Tile.TILESIZE);
			_heart100 = new FlxSprite(X, Y, Heart100);
			_heart075 = new FlxSprite(X, Y, Heart075);
			_heart050 = new FlxSprite(X, Y, Heart050);
			_heart025 = new FlxSprite(X, Y, Heart025);
			_heart000 = new FlxSprite(X, Y, Heart000);
			_heart100.scrollFactor = 
			_heart075.scrollFactor = 
			_heart050.scrollFactor = 
			_heart025.scrollFactor = 
			_heart000.scrollFactor = 
			this.scrollFactor = new FlxPoint(0, 0);
			_currentSprite = _heart100;
		}
		override public function hurt(Damage:Number):void {
			this.flicker(.5);
			if (health < Damage) {
				if (next != null) next.hurt(Damage - health);
				health = 0;
				_currentSprite = _heart000;
				return;
			}
			health -= Damage;
			var nextSprite:FlxSprite;
			switch (health) {
				case 4: nextSprite = _heart100; break;
				case 3: nextSprite = _heart075; break;
				case 2: nextSprite = _heart050; break;
				case 1: nextSprite = _heart025; break;
				case 0: nextSprite = _heart000; break;
				default: nextSprite = _currentSprite;
			}
			if (nextSprite != _currentSprite) {	_currentSprite = nextSprite; }
		}
		override public function render():void 
		{
			_currentSprite.render();
		}
	}
}