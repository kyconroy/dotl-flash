package com.darkdefense.towers 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.PlayerStats;
	import com.darkdefense.tiles.Tile;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class UpgradedStarburstTower extends StarburstTower
	{
		private const ATTACK_SPEED:Number = 3 * (1 - (PlayerStats.SpeedPoints * PlayerStats.SPEED_BOOST));
		[Embed(source = '../../../assets/images/upgraded-starburst-tower.png')] private var ImgTower:Class;
		
		public function UpgradedStarburstTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true, Factor:Number = 1.5):void
		{
			super(ParentLevel, X, Y, false, Factor);
			_buildKey = "";
			_towerImage = ImgTower;
			_towerName = "Upgraded Starburst Tower";
			_towerData = "Illuminates and Stuns";
			loadGraphic(ImgTower);
			_upgradesInto = null;
			this.isUpgraded = true;
			_speed = ATTACK_SPEED;
			if (Built){
				_level.loggingEvents.addEvent("TowerUpgraded", ParentLevel.fullLevelID + "@UpgradedStarburstTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("StarburstTowersUpgraded", 1);
			}
		}
	}
}