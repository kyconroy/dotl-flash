package org.flixel.data
{
	import org.flixel.*;
	
	/**
	 * This is a special effects utility class to help FlxGame do the 'fade' effect.
	 */
	public class FlxFade extends FlxSprite
	{
		/**
		 * How long the effect should last.
		 */
		protected var _delay:Number;
		/**
		 * Callback for when the effect is finished.
		 */
		protected var _complete:Function;
		protected var _reverse:Boolean = false;
		/**
		 * Constructor initializes the fade object
		 */
		public function FlxFade()
		{
			super();
			createGraphic(FlxG.width,FlxG.height,0,true);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			exists = false;
		}
		
		/**
		 * Reset and trigger this special effect
		 * 
		 * @param	Color			The color you want to use
		 * @param	Duration		How long it should take to fade the screen out
		 * @param	FadeComplete	A function you want to run when the fade finishes
		 * @param	Force			Force the effect to reset
		 */
		public function start(Color:uint=0xff000000, Duration:Number=1, FadeComplete:Function=null, Force:Boolean=false, Reverse:Boolean = false):void
		{
			if (!Force && exists) return;
			_reverse = Reverse;
			fill(Color);
			_delay = Duration;
			_complete = FadeComplete;
			if (!_reverse) alpha = 0;
			else alpha = 1;
			exists = true;
		}
		
		/**
		 * Stops and hides this screen effect.
		 */
		public function stop():void
		{
			exists = false;
		}
			
		/**
		 * Updates and/or animates this special effect
		 */
		override public function update():void
		{
			if (!_reverse) {
				alpha += FlxG.elapsed/_delay;
				if(alpha >= 1)
				{
					alpha = 1;
					if(_complete != null)
						_complete();
				}
			} else {
				alpha -= FlxG.elapsed/_delay;
				if(alpha <= 0)
				{
					alpha = 0;
					if(_complete != null)
						_complete();
				}
			}
		}
	}
}
