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
	
	public class LanternTower extends LightTower
	{
		private const COOLDOWN:Number = 9 * (1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		private const ORIG_RANGE:Number = 2.5 * Tile.TILESIZE;
		private const RANGE:Number = ORIG_RANGE * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		
		[Embed(source = '../../../assets/images/tower-light.png')] private var ImgTower:Class;
		
		public override function LanternTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true, Factor:Number = 1):void
		{
			super(ParentLevel, X, Y, Built);
			_buildKey = "W";
			_towerImage = ImgTower;
			_towerName = "Lantern Tower";
			_towerData = "Illuminates Map";
			_time_between_builds = COOLDOWN;
			_range = RANGE*Factor;
			_upgradesInto = UpgradedLanternTower;
			loadGraphic(ImgTower);
			drawLight(Factor * (RANGE/ORIG_RANGE));
			ParentLevel.lights.add(_radius);
			if (Built) {
				_level.loggingEvents.addEvent("TowerBuild", ParentLevel.fullLevelID + "@LanternTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("LanternTowersBuilt", 1);
				FlxG.kong.API.stats.submit("TotalTowersBuilt", 1);
			}
		}
	}

}