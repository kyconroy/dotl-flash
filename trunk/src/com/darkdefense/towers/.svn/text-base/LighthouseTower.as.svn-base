package com.darkdefense.towers 
{
	/**
	 * ...
	 * @author Erik
	 */
	import com.darkdefense.states.Level;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import com.darkdefense.ui.Fog;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	
	public class LighthouseTower extends LightTower
	{
		private const COOLDOWN:Number = 4 * (1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		protected const ORIG_RANGE:Number = 4.5 * Tile.TILESIZE;
		protected const RANGE:Number = ORIG_RANGE * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		protected var _wedge:LightWedge;
		
		[Embed(source = '../../../assets/images/lighthouse-tower.png')] private var ImgTower:Class;
		public override function LighthouseTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true, Factor:Number = 1.15):void
		{
			super(ParentLevel, X, Y, Built);
			_buildKey = "Q";
			_towerImage = ImgTower;
			_towerName = "Lighthouse Tower";
			_towerData = "Illuminates Map";
			_time_between_builds = COOLDOWN;
			_range = RANGE;
			_upgradesInto = UpgradedLighthouseTower;
			loadGraphic(ImgTower);
			drawLight(Factor * (RANGE/ORIG_RANGE));
			ParentLevel.movingLights.add(_wedge);

			if (Built) {
				_level.loggingEvents.addEvent("TowerBuild", ParentLevel.fullLevelID + "@LighthouseTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("LighthouseTowersBuilt", 1);
				FlxG.kong.API.stats.submit("TotalTowersBuilt", 1);
			}
		}
		
		public override function update():void {
			super.update();
			_wedge.update();
		}
		
		override public function kill():void {
			super.kill();
			_wedge.kill();
			_level.movingLights.remove(_wedge, true);
		}
		
		
		override public function drawLight(factor:Number):void
		{
			scale_by = scale_by * factor;
			_wedge = new LightWedge(this.x, this.y, scale_by, _level, 0);
			_offset = (_wedge.STARTING_WEDGE_DIAMETER / 2) - width/2;
			_wedge.fogOffset.x = this.x - _offset;
			_wedge.fogOffset.y = this.y - _offset;
		}
		
	}

}