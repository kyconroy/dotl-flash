package com.darkdefense.towers 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import org.flixel.*;
	import com.darkdefense.PlayerStats;

	public class Tower extends FlxSprite
	{
	
		
		public var isSelected:Boolean;
		public var isUpgraded:Boolean;
		public var _showRadius:AttackRadius;
		public var _range:Number = 0;
		public var _damage:Number = 0;
		public var _reloadTime:Number = 0;
		public var _towerData:String = null;
		public var _upgradeSpecial:String = null;
		public var _isLightTower:Boolean = false;
		
		private var X:Number;
		private var Y:Number;
		private var _selectedSprite:SelectedTowerSprite;
		public var _towerImage:Class;
		protected static var _buildKey:String;
		protected static var _time_between_builds:Number;
		protected static var _level:Level;
		protected var _center:FlxPoint;
		protected var _centerX:Number;
		protected var _centerY:Number;
		public var _towerName:String;
		public var _upgradedSpecial:String;
		protected var _renderRadius:Boolean;
		public var _upgradesInto:Class;
		protected var _unbuildableSprite:FlxSprite;
		
		[Embed(source = "../../../assets/images/unbuildable.png")] private var ImgUnbuildable:Class;	
		
		public override function Tower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean):void
		{
			super(X, Y);
			this.X = X;
			this.Y = Y;
			_level = ParentLevel;
			isUpgraded = false;
			_upgradesInto = null;
			_selectedSprite = new SelectedTowerSprite(X, Y);
			_towerName = new String;
			_towerData = new String;
			_unbuildableSprite = new FlxSprite(X - 10, Y - 10, ImgUnbuildable);
			_unbuildableSprite.width = _unbuildableSprite.height = 50;
			_unbuildableSprite.solid = false;
			_centerX = X + Tile.TILESIZE / 2;
			_centerY = Y + Tile.TILESIZE / 2;
			_center = new FlxPoint(_centerX, _centerY);
		}
		
		override public function update():void {
			super.update();
			_selectedSprite.update();
			
			if (isSelected && !_renderRadius) 
			{
				_showRadius = new AttackRadius(this.x, this.y, _range);
				_level.ui.attackRadii.add(_showRadius);
				_renderRadius = true;
			}
		}
		
		public function get towerImage():Class { return _towerImage; }
		public function get buildKey():String { return _buildKey; }
		public function get time_between_builds():Number { return _time_between_builds; }
		
		public function get upgradesInto():Class { return _upgradesInto; }
		
		public function get center():FlxPoint { return _center; }
		public function upgrade():Boolean {
			if (_upgradesInto == null) return false;
			_level.ui.selectedItem = new _upgradesInto(_level, this.x, this.y);
			_level.atowers.remove(this, true);
			_level.unBuildable.remove(this, true);
			_level.defaultGroup.remove(this, true);
			removeLastItemSelected();
			_level.ui.selectedItem.select();
			this.kill();
			return true;
		}
		public function select():void { 
			if (_level.ui.typeSelected != null) return;
			if (_level.ui.selectedItem != null) _level.ui.selectedItem.removeLastItemSelected();
			isSelected = true;
			_level.towerSelect.add(_selectedSprite);
			_level.ui.selectedNameDisplay.text = _towerName;
			
			if (_level.ui.typeSelected == null) {
				_level.ui.showStats(_range, _damage, _reloadTime, _towerData, _upgradeSpecial, _isLightTower);
			}
		}
		public function removeLastItemSelected():void {//remove selection box
			_level.towerSelect.remove(_selectedSprite, true);
			_level.ui.selectedNameDisplay.text = _level.ui.unselectedText;
			_level.ui.hideStats();
			if (this._showRadius != null) 
			{
				this.isSelected = false;
				_level.ui.attackRadii.remove(this._showRadius, true);
				this._renderRadius = false;
			}
		}
		
		override public function kill():void {
			super.kill();
			if (_selectedSprite != null) _selectedSprite.kill();
			if (_showRadius != null) _showRadius.kill();
		}
		override public function render():void {
			if (isSelected) {
				_selectedSprite.clicked = true;
			} else {
				_selectedSprite.clicked = false;
			} 
			if (this.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y) && !isSelected) {
				_selectedSprite.hover = true;	
			} else {
				_selectedSprite.hover = false;
			}
			if (_selectedSprite.hover || _selectedSprite.clicked) {
				_selectedSprite.render();
			}
			super.render();
			if (_level.ui.typeSelected != null) {
				_unbuildableSprite.render();
			}
		}
	}

}