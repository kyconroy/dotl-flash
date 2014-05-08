package  com.darkdefense.towers
{
	import com.darkdefense.states.Level;
	import org.flixel.*;
	import com.darkdefense.enemies.Enemy;
	import com.darkdefense.tiles.Tile;
	
	/**
	 * ...
	 * @author Kyle
	 */
	public class AttackTower extends Tower
	{		
		public var inLight:Boolean = false;
		
		protected var _splash:Boolean;
		protected var _attackSprite:AttackSprite;
		protected var _type:int;
		protected var _timer:Number;
		public var _attackSpriteImage:Class;
		protected var _attackSound:Class;
				
		public override function AttackTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean) 
		{
			super(ParentLevel, X, Y, Built);
			ParentLevel.unBuildable.add(this);
			ParentLevel.atowers.add(this);
			_time_between_builds = 5;
			_renderRadius = false;
			isSelected = false;
		}
		
		public override function update():void
		{
			super.update();
			if (_timer <= 0)
			{
				attack();
				_timer = _reloadTime;
			}
			_timer -= _level.enemySpeed * FlxG.elapsed;
		}	
		
		override public function kill():void {
			_level.atowers.remove(this, true);
			super.kill();
		}
		private function attack():void
		{
			if (!inLight) return;
			var _attackList:Array = new Array;
			for each (var _enemy:Enemy in _level.enemies.members) 
			{
				if (_enemy._shroudTimer > 0) continue;
				if (_enemy == null) continue;
				var _withinRange:Boolean = false;
				//check if the enemy is in the Tower's range
				_withinRange = ((Math.abs(_enemy.centerX - _centerX) <= _range) && (Math.abs(_enemy.centerY - _centerY) <= _range));
				if(_withinRange && _enemy.isVisible() && !_enemy.dead)
				{	
					_attackList.push(_enemy); //add the enemy to attackList
					_attackList.sortOn(((_enemy.x - this.x)*(_enemy.x - this.x)) + ((_enemy.y - this.y)*(_enemy.y - this.y))); //Find the closest enemy to the base
				}
			}
			
			var _currentTarget:Enemy;
			if (_attackList != null && _attackList.length > 0)
			{
				if (_attackSound != null) FlxG.play(_attackSound);
				_currentTarget = _attackList[0];
				_attackSprite = new AttackSprite(_centerX, _centerY, 0, 0, _attackSpriteImage,  _damage, _type, _currentTarget, _level);
				
				if (_type == 3 && _attackList.length > 1) // multishot tower and more than one enemy in range
				{ 
					_currentTarget = _attackList[1];
					_attackSprite = new AttackSprite(_centerX, _centerY, 0, 0, _attackSpriteImage,  health, _type, _currentTarget, _level);
				}
			}
		}
		
		public function get range():int { return _range; }
	}
}