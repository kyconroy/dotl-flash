package com.darkdefense.ui
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import com.darkdefense.states.Level;
	
	public class ButtonCallback extends FlxSprite
	{
		private var _key:String;
		override public function ButtonCallback(ParentLevel:Level, Key:String, Callback:Function):void
		{
			super(0, 0);
			this.solid = false;
			this.visible = false;
			_key = Key;
			_callback = Callback;
			ParentLevel.add(this);
		}
		override public function update():void {
			if (FlxG.keys.justPressed(_key)) {
				_callback();
				kill();
			}
		}
	}

}