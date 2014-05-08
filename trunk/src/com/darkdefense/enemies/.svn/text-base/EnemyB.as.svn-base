package com.darkdefense.enemies
{
	import com.darkdefense.states.Level;
	import org.flixel.FlxG;
    import org.flixel.data.FlxAnim;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class EnemyB extends Enemy
	{
		[Embed("../../../assets/images/enemy-b.png")] private var ImgB:Class;
		[Embed("../../../assets/images/animations/enemy-b-animation.png")] private var ImgBAnimated:Class;
        
        private var _level:Level;
		public function EnemyB(Base:EnemyBase, hp:Number, id:int, ParentLevel:Level, Shroud:Number = 0):void
		{
			super(Base, hp, id, ParentLevel, Shroud);
			//loadGraphic(ImgB);
            _level = ParentLevel;
			loadGraphic(ImgBAnimated, true, false, 24, 24);
            this.offset.y = 4;
			this.offset.x = 4;
			this.width = 16;
			this.height = 16;
            
            addAnimation("forward", [0, 1, 2], (_framesPerSecond * ParentLevel.enemySpeed));
			addAnimation("shrouded", [3, 4, 5], (_framesPerSecond * ParentLevel.enemySpeed));
			
			this._walkspeed = 0.75 * _walkspeed;
			this._armor = 2;
		}
		override public function update():void {
            super.update();
            _animations[0].delay = 1 / (_framesPerSecond * _level.enemySpeed);
            
            if (_shroudTimer > 0) play("shrouded");
            else play("forward");
		}
	}

}