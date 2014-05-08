package com.darkdefense.enemies
{
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.towers.LanternTower;
	import flash.geom.Point;
	import org.flixel.*;
	import com.darkdefense.states.Level;
	import com.darkdefense.PlayerStats;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class Enemy extends FlxSprite
	{
		[Embed("../../../assets/images/shroud.png")] private var ImgShroud:Class;
		public static const SHROUD_DURATION:Number = 8;
		
		protected var _enemyHitSound:Class;
		protected var _lastSpeed:Number = 0;
		protected var _walkspeed:Number = Tile.TILESIZE;
		protected var _slowfactor:Number = 0.5;
		protected var _framesPerSecond:Number = 7;
		private var _base:EnemyBase;
		private var _lastTile:Tile;
		private var _level:Level;
		private var _attackable:Boolean;
		private var _lastSlowFor:Number = 0;
		private var _slowFor:Number;
		private var _stunFor:Number;
		private var _startingHealth:Number;
		private var _healthBar:EnemyHealth;
		private var _healthBarAdded:Boolean;
		private var _showHealth:Boolean;
		private var _shroud:FlxSprite;
		private var _shroudTime:Number;
		protected var _armor:Number = 0;
		
		public var speed:Number;
		public var damage:Number;
		public var _shroudTimer:Number;
		
		public static var movementCallback:Function;
		
		/* 0 - normal
		 * 1 - armored
		 * 2 - magician */
		private var _type:int = -1;
		private var _order:int;
		private var _direction:int;
		private var _lastDirection:int;
		[Embed("../../../assets/sounds/enemy-hit.mp3")] private var EnemyHit:Class;
		public function Enemy(Base:EnemyBase, hp:int, id:int, ParentLevel:Level, ShroudTime:Number = 0, HitSound:Class=null):void		
		{
			_base = Base;
			super(_base.x + _base.width / 4, _base.y + _base.height / 4);
			_enemyHitSound = HitSound;
			if (_enemyHitSound == null) _enemyHitSound = EnemyHit;
			movementCallback = movementHandler;
			health = hp;
			_startingHealth = hp;
			_order = id;
			_level = ParentLevel;
			_attackable = false;
			fixed = true;
			speed = _walkspeed;
			_slowFor = 0;
			_stunFor = 0;
			changeDirection(_base.getDirection());
			_level.enemies.add(this);
			_level.add(this);
			_healthBarAdded = false;
			damage = 2;
			_healthBar = new EnemyHealth(centerX, centerY, _startingHealth);
			_shroudTime = _shroudTimer = ShroudTime;
			//if (_shroudTime > 0) {
				//_shroud = new FlxSprite(this.x, this.y, ImgShroud);
			//}
		}
		
		override public function update():void
		{
			super.update();
			if (_healthBar.visible) _healthBar.updatePosition(this.x, this.y, this.health);
			if ((_shroudTimer > 0) && _attackable) {
					_shroudTimer -= _level.enemySpeed * FlxG.elapsed;
			}
			
			if (_level.ui.typeSelected == null) alpha = 1;
			else alpha = 0.7;
			speed = calculateSpeed();
			
			if (_level.enemySpeed <= 0.01) {
				this.velocity.x = this.velocity.y = 0;
			} else if (_lastSpeed <= 0.01) changeDirection(_direction);
			_lastSpeed = _level.enemySpeed;
			
			if (this.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y) && this.visible) {
				_showHealth = true;
			}
		}
		
		override public function kill():void
		{
			super.kill();
			if (health <= 0) {
				FlxG.kong.API.stats.submit("EnemiesKilled", 1);
				_level.gameScore += _startingHealth;
			}
			_level.enemyHealths.remove(_healthBar);
		}
		
		public static function changeAttackable(e:Enemy, l:LightRadius):void
		{
			if (l.checkDistance(e.center)) {
				e._attackable = true;
			}
		}
		
		public function isVisible():Boolean 
		{
			return _attackable;
		}

		private static function movementHandler(e:Enemy, t:Tile):void {
			if (t == e._lastTile || t == null)
				return;
			if (e.overlapsPoint(t.x + t.width  / 2 + ((e.velocity.x/e.speed) * (e.width/2  - 1)), 
							  t.y + t.height / 2 + ((e.velocity.y/e.speed) * (e.height/2 - 1)))) {
				e._lastTile = t;
				e.changeDirection(t.getDirection());
				if (e._lastDirection != e._direction) {
					e.centerX = t.centerX;
					e.centerY = t.centerY;
				}
			}
		}
		
		public function GetOrderNum():int
		{
			return _order;
		}
		
		public function changeDirection(Dir:Number):void 
		{
			velocity.x = 0;
			velocity.y = 0;
			_lastDirection = _direction;
			_direction = Dir;
			switch (Dir) {
				case Tile.NORTH:
					this.velocity.y = -this.speed;
					break;
				case Tile.SOUTH:
					this.velocity.y = this.speed;
					break;
				case Tile.EAST:
					this.velocity.x = this.speed;
					break;
				case Tile.WEST: 
					this.velocity.x = -this.speed;
					break;
			}
		}
		
		public function get type():int { return _type; }
		
		public function set attackable(value:Boolean):void 
		{
			_attackable = value;
		}
		
		public function slow(slowFor:Number):void {
			_slowFor = slowFor;
		}
		
		public function stun(stunTime:Number):void {
			_stunFor = stunTime;
		}
		override public function hurt(Damage:Number):void {
			super.hurt(Damage - _armor);
			if (Damage - _armor > 0) {
				//FlxG.play(_enemyHitSound);
				this.flicker(.2);
			}
		}
		
		override public function render():void {
			super.render();
			if (_showHealth) {
				_healthBar.visible = true;
				_healthBar.render();
				_showHealth = false;
			} else {
				_healthBar.visible = false;
			}
			if (_shroud != null) {
				_shroud.render();
			}
		}
		protected function calculateSpeed():Number {
			var speed:Number;
			if (_stunFor > 0) {
				speed = 0;
				changeDirection(_direction);
				_stunFor -= _level.enemySpeed * FlxG.elapsed;
			} else {
				if (_slowFor > 0) {
					speed = _level.enemySpeed * _walkspeed * _slowfactor;
					changeDirection(_direction);
					_lastSlowFor = _lastSlowFor;
					_slowFor -= _level.enemySpeed * FlxG.elapsed;
				} else if (_slowFor <= 0) {
					speed = _level.enemySpeed * _walkspeed;
					changeDirection(_direction);
				}
			}
			return speed;
		}
		public function get centerX():int {
			return x + width / 2;
		}
		public function set centerX(X:int):void {
			this.x = X - width /2;
		}
		public function get centerY():int {
			return y + height/2;
		}
		public function set centerY(Y:int):void {
			this.y = Y - height/2;
		}
		public function get center():FlxPoint {
			return new FlxPoint(centerX, centerY);
		}
	}

}