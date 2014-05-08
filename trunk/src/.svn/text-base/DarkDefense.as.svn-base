package 
{
	import com.darkdefense.states.RedirectState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.flixel.*;
	import com.darkdefense.states.OverWorld;
	import com.darkdefense.PlayerStats;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.UI;
	import org.flixel.data.FlxConsole;
	
	/**
	 * ...
	 * @author DarkDefense
	 */
	public class DarkDefense extends FlxGame
	{
		
		[SWF(width = "800", height = "600", backgroundColor = "#000000")]
		[Frame(factoryClass = "Preloader")]
		
		[Embed(source = "assets/fonts/Diavlo_MEDIUM_II_37.otf", fontName = "diavlo", fontFamily = "sans")] private var diavlo:Class;
		[Embed(source = "assets/images/pausemenu.png")] private var PauseMenu:Class;
		
		public static var pauseGroup:FlxGroup;
		public static var console:FlxConsole;
		public static var currentGame:FlxGame;
		public static var BeepSound:Class;
		
		public function DarkDefense():void 
		{
			super(800, 600, OverWorld, 1);
			new PlayerStats();
			currentGame = this;
			useDefaultHotKeys = false;
			pauseGroup = pause = new FlxGroup();
			var pausedSprite:FlxSprite = new FlxSprite(0, 0);
			pausedSprite.loadGraphic(PauseMenu);
			
			pause.width = pausedSprite.width;
			pause.height = pausedSprite.height;
			pause.x = FlxG.width / 2 - pause.width / 2;
			pause.y = FlxG.height / 2 - pause.height / 2;
			pause.add(pausedSprite);
			BeepSound = SndBeep;
		}
		
		override public function showSoundTray(silent:Boolean = false):void {
			if (!silent) FlxG.play(SndBeep);
		}
		
		override protected function onKeyUp(event:KeyboardEvent):void
		{
			var c:int = event.keyCode;
			var code:String = String.fromCharCode(event.charCode);
			switch(c)
			{
				case 48:
				case 96:
					FlxG.mute = !FlxG.mute;
					showSoundTray();
					return;
				case 109:
				case 189:
					FlxG.mute = false;
					FlxG.volume = FlxG.volume - 0.1;
					showSoundTray();
					return;
				case 107:
				case 187:
					FlxG.mute = false;
					FlxG.volume = FlxG.volume + 0.1;
					showSoundTray();
					return;
				default: break;
			}
			super.onKeyUp(event);
		}
		override protected function onFocusLost(event:Event = null):void {
			;
		}
		
	}
	
}