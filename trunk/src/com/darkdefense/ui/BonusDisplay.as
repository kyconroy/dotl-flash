package com.darkdefense.ui 
{
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.Level;
	/**
	 * ...
	 * @author Erik
	 */
	public class BonusDisplay extends FlxSprite
	{
		private var _level:Level;
		private var _x:Number;
		private var _y:Number;
		private var _bonus:Number;
		private var _text:FlxText;
		
		public function BonusDisplay(X:Number, Y:Number, _level:Level, bonus:Number):void 
		{
			super(X,Y);
			this._level = _level;
			_x = X;
			_y = Y;
			this._bonus = bonus;
			_text = new FlxText(X, Y, Tile.TILESIZE, "+" + bonus);
			_text.setFormat(null, 14, 0xFFFFCC11, "left");
			_text.scrollFactor = new FlxPoint(0, 0);
			_text.shadow = 2;
		}
		
		override public function update():void
		{
			super.update();
			_text.x = this.x;
			_text.y = this.y;

			if (this.y < _y - (Tile.TILESIZE * 3 / 4)) 
				this.kill();
		}			
		
		override public function render():void
		{
			_text.render();
		}
	}
}