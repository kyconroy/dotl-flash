package com.darkdefense.enemies
{
	import com.darkdefense.states.Level;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class EnemyA extends Enemy
	{
		[Embed("../../../assets/images/enemy-a.png")] private var ImgA:Class;
        [Embed("../../../assets/images/animations/enemy-a-animation.png")] private var ImgAAnimated:Class;
        
        private var _level:Level;
		public function EnemyA(Base:EnemyBase, hp:Number, id:int, ParentLevel:Level, Shroud:Number = 0):void
		{
			super(Base, hp, id, ParentLevel, Shroud);
			//loadGraphic(ImgA);
            _level = ParentLevel;
            loadGraphic(ImgAAnimated, true, false, 20, 20);
			this.offset.y = 4;
			this.offset.x = 3;
			this.width = 16;
			this.height = 16;
            
            addAnimation("forward", [0, 1, 2], (_framesPerSecond * ParentLevel.enemySpeed));
			addAnimation("shrouded", [3, 4, 5], (_framesPerSecond * ParentLevel.enemySpeed));
		}
		override public function update():void {
            //this._framesPerSecond = this._framesPerSecond * _level.enemySpeed;
            super.update();
            //updateAnimation();
            _animations[0].delay = 1 / (_framesPerSecond * _level.enemySpeed);
			if (_shroudTimer > 0) play("shrouded");
            else play("forward");
		}
	}

}