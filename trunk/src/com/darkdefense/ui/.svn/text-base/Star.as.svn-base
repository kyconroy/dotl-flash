package com.darkdefense.ui
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.Level;
	
	public class Star extends FlxSprite
	{
		[Embed("../../../assets/images/star100.png")] private var Star100:Class;
		[Embed("../../../assets/images/star050.png")] private var Star050:Class;
		[Embed("../../../assets/images/star000.png")] private var Star000:Class;
		
		private var _star100:FlxSprite;
		private var _star050:FlxSprite;
		private var _star000:FlxSprite;
		private var _currentSprite:FlxSprite;
		private var _level:Level;
		
		public function Star(X:Number, Y:Number) 
		{
			super();
			this.x = X;
			this.y = Y;
			this.width = this.height = FlxU.ceil(0.66 * Tile.TILESIZE);
			_star100 = new FlxSprite(X, Y, Star100);
			_star050 = new FlxSprite(X, Y, Star050);
			_star000 = new FlxSprite(X, Y, Star000);
			_star100.scrollFactor = 
			_star050.scrollFactor = 
			_star000.scrollFactor = 
			this.scrollFactor = new FlxPoint(0, 0);
			_currentSprite = _star000;
		}
		public function set(Fill:int):void {
			switch (Fill) {
				case 0:  _currentSprite = _star000; break;
				case 1:  _currentSprite = _star050; break;
				default: _currentSprite = _star100; break
			}
		}
		override public function render():void 
		{
			_currentSprite.render();
		}
	}
}