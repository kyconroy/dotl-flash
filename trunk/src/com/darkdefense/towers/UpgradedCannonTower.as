package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import org.flixel.*;
	
	public class UpgradedCannonTower extends CannonTower
	{
		private const TYPE:int = 4;
		
		[Embed(source = "../../../assets/images/cannonball-splash.png")] private var ImgShot:Class;
		[Embed(source = "../../../assets/images/upgraded-cannon-tower.png")] private var ImgTower:Class;		
		public override function UpgradedCannonTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean = true):void
		{
			super(ParentLevel, X, Y,false);
			_towerName = "Upgraded Cannon Tower";
			_towerImage = ImgTower;
			_buildKey = "";
			_towerData = "Splash damage";
			_upgradesInto = null;
			_upgradedSpecial = "Does not upgrade";
			_type = TYPE;
			_attackSpriteImage = ImgShot;
			this.isUpgraded = true;
			loadGraphic(ImgTower);
			if (Built) {
				_level.loggingEvents.addEvent("TowerUpgraded", ParentLevel.fullLevelID + "@UpgradedCannonTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("CannonTowersUpgraded", 1);
			}
		}
	}
}