package com.darkdefense.ui
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import com.darkdefense.states.Level;
	
	public class TimedCallback extends FlxSprite
	{
		private var _timer:Number;
		private var _level:Level;
		override public function TimedCallback(ParentLevel:Level, Time:Number, Callback:Function):void
		{
			super(0, 0);
			this.solid = false;
			this.visible = false;
			_timer = Time;
			_callback = Callback;
			_level = ParentLevel;
			if (ParentLevel != null) ParentLevel.add(this);
		}
		override public function update():void {
			var modifier:Number = 1;
			if (_level != null) modifier = _level.enemySpeed
			_timer -= FlxG.elapsed * modifier;
			if (_timer <= 0) {
				_callback();
				kill();
			}
		}
	}

}