package com.darkdefense.towers 
{
	import com.darkdefense.states.Level;
	import org.flixel.*;
	import com.darkdefense.ui.Fog;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.towers.UpgradedLanternTower;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	
	public class LightTower extends Tower
	{		
		//Private variables

		private var _drawn:Boolean = true;
		
		//protected var _radi:AttackRadius;
		protected var _offset:Number;
		protected var _radius:LightRadius;
		// 0.375 for normal light tower; 0.5 for upgraded; 0.625 for 'ultimate'
		
		public var scale_by:Number = 0.6;
		
		public function LightTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean):void
		{
			super(ParentLevel, X, Y, Built);
			this.width = Tile.TILESIZE;
			this.height = Tile.TILESIZE;
			
			center.x = this.x + (this.width / 2);
			center.y = this.y + (this.height / 2);
			
			ParentLevel.unBuildable.add(this);
			ParentLevel.ltowers.add(this);
			
			_showRadius = new AttackRadius(this.x, this.y, _range);
			_isLightTower = true;
			//if (Built) _level.loggingEvents.addEvent("TowerBuild", PlayerStats.Currentlevel + "/"+PlayerStats.LevelPlayCounter+"/"+ "LanternTower@" + this.x + "," + this.y)
		}
		
		override public function upgrade():Boolean {
			_level.ltowers.remove(this, true);
			_level.lights.remove(this._radius, true);
			return super.upgrade();
		}
		
		override public function kill():void {
			if (_level != null) {
				_level.lights.remove(_radius, true);
				_level.movingLights.remove(_radius, true);
				_level.ltowers.remove(this, true);
				_level.unBuildable.remove(this, true);
				if (_level.fog != null) _level.fog.lightsChanged = true;
			}
			if (_radius != null) _radius.kill();
			super.kill();
		}
		
		override public function removeLastItemSelected():void {
			super.removeLastItemSelected();
			if (this._showRadius != null) 
			{
				this.isSelected = false;
				_level.ui.attackRadii.remove(this._showRadius);
				this._renderRadius = false;
			}
		}
		
		public function drawLight(factor:Number):void
		{
			scale_by = scale_by * factor;
			_radius = new LightRadius(this.x, this.y, scale_by);
			if (_level.fog != null) _level.fog.lightsChanged = true;
			_offset = (_radius.STARTING_DIAMETER / 2) - width/2;
			_radius.fogOffset.x = this.x - _offset;
			_radius.fogOffset.y = this.y - _offset;
		}
	}

}