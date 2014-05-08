package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import org.flixel.*;
	
	public class UpgradedArrowTower extends ArrowTower
	{
		private const RANGE:int = 2*Tile.TILESIZE  * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		private const TYPE:int = 3;
		
		[Embed(source = "../../../assets/images/arrow.png")] private var ImgArrow:Class;
		[Embed(source = "../../../assets/images/upgraded-arrow-tower.png")] private var ImgTower:Class;	
		public override function UpgradedArrowTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean = true):void
		{
			super(ParentLevel, X, Y,false);
			_towerName = "Upgraded Arrow Tower";
			_towerImage = ImgTower;
			_buildKey = "";
			_towerData = "Multi-shot";
			_upgradedSpecial = "Does not upgrade";
			_type = TYPE;
			_range = RANGE;
			_attackSpriteImage = ImgArrow;
			_upgradesInto = null;
			loadGraphic(ImgTower);
			this.isUpgraded = true;
			if (Built) {
				_level.loggingEvents.addEvent("TowerUpgraded", ParentLevel.fullLevelID + "@UpgradedArrowTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("ArrowTowersUpgraded", 1);
			}
		}
	}
}