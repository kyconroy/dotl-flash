package com.darkdefense.towers 
{
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
    import flash.display.Shape;
	/**
	 * ...
	 * @author David
	 */
	public class SelectedTowerSprite extends FlxSprite
	{
		//private var _x:Number;
		//private var _y:Number;
		//private var myShape:Shape;
		
		[Embed(source = '../../../assets/images/selected.png')] private var Img:Class;
		[Embed(source = '../../../assets/images/selected-inactive.png')] private var ImgInactive:Class;
		public var hover:Boolean;
		public var clicked:Boolean;
		private var flashTime:Number = 0.5;
		private var flashTimeDirection:Number = 1;
		private const _TARGET_ALPHA:Number = 0.75;
		
		public function SelectedTowerSprite(X:Number, Y:Number, Active:Boolean = true) :void
		{
			super(X - 3, Y - 3);
			solid = false;
			
			if (Active) loadGraphic(Img);
			else loadGraphic(ImgInactive);
		}
		
		override public function update():void {
			super.update();
			flashTime += flashTimeDirection * FlxG.elapsed;
			if (flashTime > 1 || flashTime < .25) {
				flashTimeDirection *= -1;
			}
			if (hover){
				alpha = flashTime * _TARGET_ALPHA;
				if (clicked) {
					alpha = 1;
					flashTime = 0.5;
				}
			} else {
				if (clicked) this.alpha = 1;
				else alpha = 0.5;
				flashTime = 0.5;
			}
		}
		
		
	}
}