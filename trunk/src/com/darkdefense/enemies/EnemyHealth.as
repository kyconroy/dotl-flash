package com.darkdefense.enemies 
{
	
	import flash.display.Shape;
	import org.flixel.*;
	/**
	 * ...
	 * @author David
	 */
	public class EnemyHealth extends FlxSprite
	{
		
		public var _x:Number;
		public var _y:Number;
		private var _healthBar:Number;
		private var _maxHealth:Number;
		private var _myShape:Shape;
		
		public function EnemyHealth(X:Number, Y:Number, health:Number): void
		{
			super(-30,-30);

			this._healthBar = health;
			this._maxHealth = health;
			this._x = X;
			this._y = Y;
		}
		
		override public function render():void
		{
			super.render();
			if (visible) {
				_myShape = new Shape();
				var _healthPercent:Number = _healthBar / _maxHealth;
				if(_healthPercent>.6){
					_myShape.graphics.beginFill(0x7FFF00);
				}else if (_healthPercent > .4) {
					_myShape.graphics.beginFill(0xEEBC1D);
				}else if(_healthPercent>.25){
					_myShape.graphics.beginFill(0xFFA500);
				}else if (_healthPercent > .1) {
					_myShape.graphics.beginFill(0xCC0000);
				}
				_myShape.graphics.drawRect(_x+18,_y+(_maxHealth-_healthBar)/_maxHealth*8,3,_healthBar/_maxHealth*8);
				FlxG.buffer.draw(_myShape);
			}
		}
		
		public function updatePosition(X:Number, Y:Number, _healthBar:Number):void
		{
			_x = X;
			_y = Y;
			this._healthBar = _healthBar;
		}
	}
}