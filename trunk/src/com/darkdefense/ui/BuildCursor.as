package com.darkdefense.ui
{
	import com.darkdefense.states.Level;
	import org.flixel.*;
	import com.darkdefense.towers.*;
	import com.darkdefense.tiles.*;
	import com.darkdefense.ui.UI;
	
	public class BuildCursor extends FlxSprite
	{
				
		public var center:FlxPoint = new FlxPoint(0, 0);
		public var canBuildHere:Boolean = false;
		
		private var _fracTimeRemaining:Number = 0;
		private var _buildDisplay:FlxSprite;
		private var _unbuildDisplay:FlxSprite;
		private var _giantX:FlxSprite;
		private var _clock:ClockSprite;
		private var _showRange:AttackRadius;
		public var t:Tower;
		private var _level:Level;
		private var _hide:Boolean = false;

		[Embed(source = "../../../assets/images/nobuild.png")] private var ImgNobuild:Class;
		[Embed(source = "../../../assets/images/buildable.png")] private var ImgBuildable:Class;
		[Embed(source = "../../../assets/images/unbuildable.png")] private var ImgUnbuildable:Class;
		
		public function BuildCursor(ParentLevel:Level, X:Number, Y:Number, TowerType:Class)
		{
			super(X, Y);
			t = new TowerType(ParentLevel, 0, 0, false) as Tower;
			t.select();
			ParentLevel.ui.selectedItem = t;
			t.kill();
			_level = ParentLevel;

			loadGraphic(t.towerImage);
			
			this.center.x = this.x + (this.width / 2);
			this.center.y = this.y + (this.height / 2);
			
			_showRange = new AttackRadius(this.x, this.y, t._range);
			_level.ui.attackRadii.add(_showRange);
			
			_buildDisplay = new FlxSprite(this.x - 10, this.y - 10, ImgBuildable);
			_buildDisplay.width = _buildDisplay.height = 50;
			_buildDisplay.solid = false;
			
			_unbuildDisplay = new FlxSprite(this.x - 10, this.y - 10, ImgUnbuildable);
			_unbuildDisplay.width = _unbuildDisplay.height = 50;
			_unbuildDisplay.solid = false;
			
			_giantX = new FlxSprite(this.x, this.y, ImgNobuild);
			_giantX.alpha = 0;
			this.alpha = 0.3;
			_clock = new ClockSprite(this.x, this.y);
		}
		
		override public function update():void
		{
			super.update();
			
			this.x = FlxG.mouse.x;
			this.y = FlxG.mouse.y;
			this.x -= x % Tile.TILESIZE;
			this.y -= y % Tile.TILESIZE;
			
			this.center.x = x + (this.width / 2);
			this.center.y = y + (this.width / 2);
			
			this.center.x -= this.center.x % (Tile.TILESIZE / 2);
			this.center.y -= this.center.y % (Tile.TILESIZE / 2);
			
			_buildDisplay.x = this.x - 10;
			_buildDisplay.y = this.y - 10;
			_unbuildDisplay.x = this.x - 10;
			_unbuildDisplay.y = this.y - 10;
			_giantX.x = this.x;
			_giantX.y = this.y;
			var b:FlxButton = _level.ui.deselectButton;
			_hide = false;
			if (this.x < (b.x + b.width) && this.y < (b.y + b.height)) _hide = true;

			_level.ui.attackRadii.remove(_showRange, true);
			if (!_hide) _level.ui.attackRadii.add(_showRange);
			if (canBuildHere) {
				_buildDisplay.alpha = 1;
				_unbuildDisplay.alpha = 0;
				_giantX.alpha = 0;
			} else {
				_buildDisplay.alpha = 0;
				_unbuildDisplay.alpha = 1;
				_giantX.alpha = 1;
				if (FlxG.mouse.justReleased() && !_hide && x < 20 * Tile.TILESIZE) {
					_level.ui.showToolTip(this.x, this.y, "Cannot Build Here");
				}
			}
 			_showRange.X = this.x+Tile.TILESIZE/2;
			_showRange.Y = this.y + Tile.TILESIZE / 2;
		}
		
		override public function render():void {
			if (this.x >= 20 * Tile.TILESIZE) return;
			if (_hide) return;
			super.render();
			_giantX.render();
			_buildDisplay.render();
			_unbuildDisplay.render();
			_clock.render();
			//_showRange.render();
		}
		
		public function set fracTimeRemaining(value:Number):void 
		{
			_fracTimeRemaining = value;
			_clock.updateCoolDown(this.x, this.y, _fracTimeRemaining);
		}
		
		override public function kill():void {
			super.kill();
			_showRange.kill();
			_clock.kill();
			_giantX.kill();
			_unbuildDisplay.kill();
			_buildDisplay.kill();
		}
		
	}
}