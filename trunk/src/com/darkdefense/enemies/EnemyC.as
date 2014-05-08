package com.darkdefense.enemies
{
	import com.darkdefense.states.Level;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class EnemyC extends Enemy
	{
		[Embed("../../../assets/images/enemy-c.png")] private var ImgC:Class;
        [Embed("../../../assets/images/animations/enemy-c-animation.png")] private var ImgCAnimated:Class;
        private var _level:Level;
        
		public function EnemyC(Base:EnemyBase, hp:Number, id:int, ParentLevel:Level, Shroud:Number = 0):void
		{
			super(Base, hp, id, ParentLevel, Shroud);
			//loadGraphic(ImgC);
            _level = ParentLevel;
            loadGraphic(ImgCAnimated, true, false, 20, 20);
			this.offset.x = 3;
			this.offset.y = 4;
			this.width = 16;
			this.height = 16;
            this._framesPerSecond = 10;
            
            addAnimation("forward", [0, 1, 2], (_framesPerSecond * ParentLevel.enemySpeed));
			addAnimation("shrouded", [3, 4, 5], (_framesPerSecond * ParentLevel.enemySpeed));
			
			this._walkspeed = 2 * _walkspeed;
		}
		override public function update():void {
            //this._framesPerSecond = this._framesPerSecond * _level.enemySpeed;
            super.update();
            _animations[0].delay = 1 / (_framesPerSecond * _level.enemySpeed);
            //updateAnimation();
            if (_shroudTimer > 0) play("shrouded");
            else play("forward");
		}
		override protected function calculateSpeed():Number {
			var speed:Number = super.calculateSpeed();
			return speed;
		}
	}

}