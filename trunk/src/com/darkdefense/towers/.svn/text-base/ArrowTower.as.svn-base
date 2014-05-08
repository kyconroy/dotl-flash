package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	import org.flixel.*;
	
	public class ArrowTower extends AttackTower
	{
		private const ATTACK_SPEED:Number = .5 * (1 - (PlayerStats.SpeedPoints * PlayerStats.SPEED_BOOST));
		private const RANGE:int = 1*Tile.TILESIZE * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		private const DAMAGE:int = 3 * (1 + (PlayerStats.DamagePoints * PlayerStats.DAMAGE_BOOST));
		private const COOLDOWN:Number = 4 * (1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		private const TYPE:int = 0;
		
		[Embed(source = "../../../assets/images/arrow.png")] private var ImgArrow:Class;
		[Embed(source = "../../../assets/images/arrow-tower.png")] private var ImgTower:Class;	
		[Embed(source = "../../../assets/sounds/arrow.mp3")] private var TowerSound:Class;		
		public override function ArrowTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true):void
		{
			super(ParentLevel, X, Y, Built);
			_towerName = "Arrow Tower";
			_towerImage = ImgTower;
			_buildKey = "A";
			_towerData = "None";
			_upgradedSpecial = "Multi-shot";
			_type = TYPE;
			_timer = _reloadTime = ATTACK_SPEED;
			_range = RANGE;
			_attackSpriteImage = ImgArrow;
			_attackSound = TowerSound;
			_damage = DAMAGE;
			_time_between_builds = COOLDOWN;
			loadGraphic(ImgTower);
			_upgradesInto = UpgradedArrowTower;
			if (Built) {
				_level.loggingEvents.addEvent("TowerBuild", ParentLevel.fullLevelID + "@ArrowTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("ArrowTowersBuilt", 1);
				FlxG.kong.API.stats.submit("TotalTowersBuilt", 1);
			}
		}
	}
}