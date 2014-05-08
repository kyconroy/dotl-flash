package com.darkdefense.towers 
{
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
	import flash.display.Shape;
	/**
	 * ...
	 * @author David
	 */
	public class ClockSprite extends FlxSprite
	{
		protected var myShape:Shape;
		private var _x:Number;
		private var _y:Number;
		private var _coolDown:Number;
		private var _flash:Number;
		private const _PIECES:int = 4;
		private var _upgrade:Boolean;
		
		public function ClockSprite(X:Number, Y:Number, Width:Number = 30, Height:Number = 30, upgrade:Boolean = false):void
		{
			super( -Tile.TILESIZE, Tile.TILESIZE);
			width = Width;
			height = Height;
			this._x = X + Width;
			this._y = Y + Height;
			_flash = 1;
			_upgrade = upgrade;
		}
		
		override public function render():void
		{
		   super.render();
		   myShape = new Shape();
		   myShape.graphics.lineStyle(1, 0, 0);
		   
			if (_coolDown > 0) {
				myShape.graphics.beginFill(0x000000,.75);
				myShape.graphics.drawRect(_x, _y, width / 2, height / 2); //4
				if(_coolDown > 1){
					myShape.graphics.drawRect(_x, _y + height / 2, width / 2, height / 2); //3
					if(_coolDown > 2){
						myShape.graphics.drawRect(_x + width / 2, _y + height / 2, width / 2, height / 2); //2
						if(_coolDown > 3){
							myShape.graphics.drawRect(_x + width / 2, _y, width / 2, height / 2); //1
							_flash = 0;
						}
					}
				}
			} else {
				var _flashing:Boolean = false;
				if (_flash < .25) {
					_flashing = false;
				} else if (_flash < .5) {
					_flashing = true;
				} else if (_flash < .75) {
					_flashing = false;
				} else if(_flash <1){
					_flashing = true;
				} else {
					_flashing = false;
				}
				if (_flash < 1) _flash+=FlxG.elapsed;
				if (_flashing) {
					myShape.graphics.beginFill(0xFFFFFF,.50);
					myShape.graphics.drawRect(_x, _y, width, height);
				}
			}
			
			
			
			FlxG.buffer.draw(myShape);
		}
		
		public function updateCoolDown(X:Number, Y:Number, coolDown:Number):void
		{
			this._x = X;
			this._y = Y;
			if (_upgrade)
				this._coolDown = _PIECES * coolDown;
			else
				this._coolDown = coolDown;
		}
	}
}