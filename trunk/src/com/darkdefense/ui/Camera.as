package com.darkdefense.ui
{
	import flash.accessibility.Accessibility;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class Camera extends FlxSprite
	{
				
		public function Camera():void
		{
			super(400, 300, null);
		}
		
		override public function update():void
		{	
			velocity.x = 0;
			velocity.y = 0;
			
			if(FlxG.keys.UP)
			{
				velocity.y = -300;
			}
			else if(FlxG.keys.DOWN)
			{
				velocity.y = 300;
			}

            if (this.y > 0 && this.y < FlxG.height) {
                FlxG.scroll.y = - this.y;
            }
			super.update();
		}
	}
}