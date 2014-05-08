package com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import org.flixel.FlxSprite;
	import com.darkdefense.enemies.*;
	import org.flixel.*;
	/**
	 * ...
	 * @author Kyle
	 */
	internal class AttackSprite extends FlxSprite
	{
		private const _SLOWTIME:Number = 3;
		private const _SPLASH_RANGE:Number = 3/2*Tile.TILESIZE;
		/* 0 - arrow    3 - upgraded arrow
		 * 1 - canon	4 - splash canon
		 * 2 - magic 	5 - slow magic   */
		private var _type:int;
		private var _target:Enemy;
		private var _towerX:Number;
		private var _towerY:Number;
		private var _level:Level;
		
		// the sprite's health is the damage it deals
		
		public override function AttackSprite(X:Number, Y:Number, XVel:Number, YVel:Number, Img:Class, 
											  damage:int, type:int, target:Enemy, level:Level):void
		{
			super(X, Y);
			loadGraphic(Img, true, true, 14, 14);
			health = damage;
			_type = type;
			_target = target;
			_level = level;
			
			maxVelocity.x = 20*Tile.TILESIZE;
			maxVelocity.y = 20*Tile.TILESIZE;
			velocity.x = _level.enemySpeed * XVel;
			velocity.y = _level.enemySpeed * YVel;
			
			width = 10;
			height = 10;
			offset.x = 2;
			offset.y = 2;
			_towerX = X - width / 2;
			_towerY = Y - height / 2;
			addAnimation("normal", [0]);
			visible = false;
			_level.add(this);
		}
		
		//sets velocity to collide with target
		private function ReTrajectory():void
		{
			FlxU.collide(_target, this);
			if (_target != null) 
			{
				visible = true;
				
				var XRatio:Number = _target.x - this.x;
				var YRatio:Number = _target.y - this.y;
				
				this.angle = Math.atan2(YRatio , XRatio) / (2 * Math.PI) * 360-90;
				
				var YtoX:Number = 1;
				if (XRatio != 0) YtoX = Math.abs(YRatio) / Math.abs(XRatio);
				
				velocity.x = _level.enemySpeed * 4 *Tile.TILESIZE;
				velocity.y = _level.enemySpeed * 4 * Tile.TILESIZE * YtoX;
				
				if (XRatio < 0)
					velocity.x *= -1;
				if (YRatio < 0)
					velocity.y *= -1;
				
				this.angularVelocity = 0;

			} else {
				reset(_towerX, _towerY);
			}
			
		}
		
		public override function update():void
		{
			super.update();	
			if (_target != null)
			{
				if (_target.dead)
				{
					kill();
				} else 
				{
					ReTrajectory();	
				}
			} 

			
		}
		
		override public function hitTop(o:FlxObject, v:Number):void { hit(o); }
		override public function hitBottom(o:FlxObject, v:Number):void { hit(o); }
		override public function hitLeft(o:FlxObject, v:Number):void { hit(o); }
		override public function hitRight(o:FlxObject, v:Number):void { hit(o); }
		public function hit(o:FlxObject):void {
			var target:Enemy = o as Enemy;
			var damage:Number = health;
			if (target._shroudTimer > 0) {
				this.kill()
				return;
			}
			
			this.kill();
			target.hurt(damage);
			
			if (_type == 5) // slow shot
			{
				target.slow(_SLOWTIME);
			}
			
			if (_type == 4) //splash damage 
			{
				_type = 2;
				health = health / 2;
				
				var _attackList:Array = new Array;
				for each (var _enemy:Enemy in _level.enemies.members) 
				{
					//damage
					if (_enemy == null) continue;
					var _withinRange:Boolean = false;

					//check if the enemy is in the Tower's range
					_withinRange = ((Math.abs(_enemy.x - this.x) <= _SPLASH_RANGE) && (Math.abs(_enemy.y - this.y) <= _SPLASH_RANGE));
					if(_withinRange && _enemy.isVisible() && !_enemy.dead && _enemy != _target)
					{	
						_attackList.push(_enemy); //add the enemy to attackList
					}
					for (var i:int = 0; i < _attackList.length; i++) {
						hit(_attackList[i]);
					}
				}
			}
			_level.defaultGroup.remove(this, true);
		}
		
	}

}