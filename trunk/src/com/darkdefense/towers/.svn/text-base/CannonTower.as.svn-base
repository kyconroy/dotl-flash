package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import org.flixel.*;
	
	public class CannonTower extends AttackTower
	{
		private const ATTACK_SPEED:Number = 2 * (1 - (PlayerStats.SpeedPoints * PlayerStats.SPEED_BOOST));
		private const RANGE:int = 3*Tile.TILESIZE * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		private const DAMAGE:int = 20 * (1 + (PlayerStats.DamagePoints * PlayerStats.DAMAGE_BOOST));
		private const COOLDOWN:Number = 15 * (1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		private const TYPE:int = 1;
		
		[Embed(source = "../../../assets/images/cannonball.png")] private var ImgShot:Class;
		[Embed(source = "../../../assets/images/cannon-tower.png")] private var ImgTower:Class;		
		[Embed(source = "../../../assets/sounds/cannon.mp3")] private var TowerSound:Class;		
		public override function CannonTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true):void
		{
			super(ParentLevel, X, Y, Built);
			_towerName = "Cannon Tower";
			_towerImage = ImgTower;
			_buildKey = "D";
			_towerData = "None";
			_upgradedSpecial = "Splash Damage";
			_type = TYPE;
			_timer = _reloadTime = ATTACK_SPEED;
			_range = RANGE;
			_attackSpriteImage = ImgShot;
			_attackSound = TowerSound;
			_damage = DAMAGE;
			_time_between_builds = COOLDOWN;
			_upgradesInto = UpgradedCannonTower;
			loadGraphic(ImgTower);
			if (Built) {
				_level.loggingEvents.addEvent("TowerBuild", ParentLevel.fullLevelID + "@CannonTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("CannonTowersBuilt", 1);
				FlxG.kong.API.stats.submit("TotalTowersBuilt", 1);
			}
			
		}
	}
}