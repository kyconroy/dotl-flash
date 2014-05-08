package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import org.flixel.*;

	public class MagicTower extends AttackTower
	{
		private const ATTACK_SPEED:Number = 1 * (1 - (PlayerStats.SpeedPoints * PlayerStats.SPEED_BOOST));
		private const RANGE:int = 2*Tile.TILESIZE * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		private const DAMAGE:int = 8 * (1 + (PlayerStats.DamagePoints * PlayerStats.DAMAGE_BOOST));
		private const COOLDOWN:Number = 9 * (1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		private const TYPE:int = 2;
		
		[Embed(source = "../../../assets/images/fireball.png")] private var ImgFire:Class;
		[Embed(source = "../../../assets/images/magic-tower.png")] private var ImgTower:Class;		
		[Embed(source = "../../../assets/sounds/fireball.mp3")] private var TowerSound:Class;		
		public override function MagicTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true):void
		{
			super(ParentLevel, X, Y, Built);
			_towerName = "Magic Tower";
			_towerImage = ImgTower;
			_buildKey = "S";
			_towerData = "None";
			_upgradedSpecial = "Slows Enemies";
			_type = TYPE;
			_timer = _reloadTime = ATTACK_SPEED;
			_range = RANGE;
			_attackSpriteImage = ImgFire;
			_attackSound = TowerSound;
			_damage = DAMAGE;
			_time_between_builds = COOLDOWN;
			_upgradesInto = UpgradedMagicTower;
			loadGraphic(ImgTower);
			if (Built) {
				_level.loggingEvents.addEvent("TowerBuild", ParentLevel.fullLevelID + "@MagicTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("MagicTowersBuilt", 1);
				FlxG.kong.API.stats.submit("TotalTowersBuilt", 1);
			}
		}
	}

}