package com.darkdefense.towers 
{
	import com.darkdefense.PlayerStats;
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.enemies.Enemy;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class StarburstTower extends LightTower
	{
		private const COOLDOWN:Number = 15 * (1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		private const ATTACK_SPEED:Number = 4 * (1 - (PlayerStats.SpeedPoints * PlayerStats.SPEED_BOOST));
		private const ORIG_RANGE:Number = 3.75 * Tile.TILESIZE;
		private const RANGE:Number = ORIG_RANGE * (1 + (PlayerStats.RangePoints * PlayerStats.RANGE_BOOST));
		private const STUN_CHANCE:Number = 0.33;
		
		protected var _speed:Number;
		protected var _timer:Number;
		protected var _stun:Number;
		
		[Embed(source = '../../../assets/images/starburst-tower.png')] private var ImgTower:Class;
		public function StarburstTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true, Factor:Number = 1.5):void
		{
			super(ParentLevel, X, Y, Built);
			_buildKey = "E";
			_towerImage = ImgTower;
			_towerName = "Starburst Tower";
			_towerData = "Lights  Stuns";
			_time_between_builds = COOLDOWN;
			_range = RANGE;
			_upgradesInto = UpgradedStarburstTower;
			_speed = ATTACK_SPEED;
			_timer = 0;
			_stun = STUN_CHANCE;
			loadGraphic(ImgTower);
			drawLight(Factor * (RANGE/ORIG_RANGE));
			ParentLevel.lights.add(_radius);

			if (Built) {
				_level.loggingEvents.addEvent("TowerBuild", ParentLevel.fullLevelID + "@StarburstTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("StarburstTowersBuilt", 1);
				FlxG.kong.API.stats.submit("TotalTowersBuilt", 1);
			}

		}
		
		public override function update():void
		{
			super.update();
			if (_timer <= 0)
			{
				burst();
				_timer = _speed;
			}
			_timer -= _level.enemySpeed * FlxG.elapsed;
		}
		
		protected function burst():void
		{
			var _attackList:Array = new Array;
			for each (var _enemy:Enemy in _level.enemies.members) 
			{
				if (_enemy == null) continue;
				var _withinRange:Boolean = false;
				//check if the enemy is in the Tower's range
				_withinRange = ((Math.abs(_enemy.centerX - _centerX) <= _range) && (Math.abs(_enemy.centerY - _centerY) <= _range));
				if(_withinRange && !_enemy.dead)
				{	
					var rand:Number = Math.random();
					if (rand <= STUN_CHANCE) {
						_enemy.flicker(.4);
						_enemy.stun(1);
					}
				}
			}
		}
	}

}