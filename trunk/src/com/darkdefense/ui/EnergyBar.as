package com.darkdefense.ui 
{
	import com.darkdefense.LevelStats;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import com.darkdefense.ui.UI;
	import com.darkdefense.states.Level;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnergyBar extends FlxGroup
	{
		[Embed(source = "../../../assets/images/energy-bar.png")] private var BarForeground:Class;
		
		private const _MAX_BAR_HEIGHT:int = 90;
		private const _FILL_COLOR:uint = 0xcc000099;
		private const _TOWER_FILL_COLOR:uint = 0x33FF0000;
		private const _TOWER_FILL_COLOR_CANBUILD:uint = 0x99009900;
		
		private var _foreGround:FlxSprite;
		private var _fill:FlxSprite;
		private var _towerFill:FlxSprite;
		private var _barHeight:int;
		private var _towerBarHeight:int = 0;
		private var _level:Level;
		
		
		override public function EnergyBar(ParentLevel:Level, X:Number, Y:Number):void
		{
			super();
			_level = ParentLevel;
			this.x = X;
			this.y = Y;
			_fill = new FlxSprite(5, 0);
			_fill.createGraphic(20, _MAX_BAR_HEIGHT, _FILL_COLOR);
			_fill.visible = false;
			this.add(_fill);
			_towerFill = new FlxSprite(5, 0);
			_towerFill.createGraphic(20, _MAX_BAR_HEIGHT, _TOWER_FILL_COLOR);
			_towerFill.visible = false;
			this.add(_towerFill);
			_foreGround = new FlxSprite(-5, -10, BarForeground);
			this.add(_foreGround);
		}
		override public function update():void {
			super.update();
			var targetBarHeight:int
			if (_level.ui != null) targetBarHeight = FlxU.floor(_MAX_BAR_HEIGHT * (_level.ui.timeSinceLastBuild / UI._MAX_BUILD_ENERGY));
			else targetBarHeight = 0;
			if (targetBarHeight < 1) _fill.visible = false;
			else if (targetBarHeight != _barHeight) {
				_fill.visible = true;
				_barHeight = targetBarHeight;
				_fill.createGraphic(20, _barHeight, _FILL_COLOR);
				_fill.y = _MAX_BAR_HEIGHT - _barHeight + this.y;
			}
			if (_towerBarHeight < 1) _towerFill.visible = false;
			else {
				_towerFill.y = _fill.y;
				_towerFill.visible = true;
				if (_towerBarHeight >= targetBarHeight) {
					_towerFill.createGraphic(20, _towerBarHeight, _TOWER_FILL_COLOR);
					_towerFill.y = _MAX_BAR_HEIGHT - _towerBarHeight + this.y;
				}
				else _towerFill.createGraphic(20, _towerBarHeight, _TOWER_FILL_COLOR_CANBUILD);
			}
		}
		
		public function set towerBarHeight(value:int):void 
		{
			if (_level.ui != null) _towerBarHeight = FlxU.floor(_MAX_BAR_HEIGHT * (value / UI._MAX_BUILD_ENERGY));
			else _towerBarHeight = 0;
		}
		
	}

}