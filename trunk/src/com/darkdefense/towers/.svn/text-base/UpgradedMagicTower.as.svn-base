package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import org.flixel.*;
	
	public class UpgradedMagicTower extends MagicTower
	{
		private const TYPE:int = 5;
		
		[Embed(source = "../../../assets/images/ice.png")] private var ImgFire:Class;
		[Embed(source = "../../../assets/images/upgraded-magic-tower.png")] private var ImgTower:Class;		
		[Embed(source = "../../../assets/sounds/iceball.mp3")] private var TowerSound:Class;		
		public override function UpgradedMagicTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean = true):void
		{
			super(ParentLevel, X, Y,false);
			_towerName = "Upgraded Magic Tower";
			_towerData = "Slow";
			_upgradedSpecial = "Does not upgrade";
			_towerImage = ImgTower;
			_attackSound = TowerSound;
			_buildKey = "";
			_type = TYPE;
			_upgradesInto = null;
			_attackSpriteImage = ImgFire;
			this.isUpgraded = true;
			loadGraphic(ImgTower);
			if (Built) {
				_level.loggingEvents.addEvent("TowerUpgraded", ParentLevel.fullLevelID + "@UpgradedMagicTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("MagicTowersUpgraded", 1);
			}
		}
	}

}