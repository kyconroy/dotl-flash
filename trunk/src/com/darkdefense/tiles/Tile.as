package com.darkdefense.tiles
{
	import com.darkdefense.states.Level;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	
	public class Tile extends FlxSprite
	{
		[Embed(source = "../../../assets/images/unbuildable.png")] private var ImgUnbuildable:Class;
		public static const TILESIZE:int = 30;
		
		public static const NORTH:int = 1;
		public static const EAST :int = 2;
		public static const SOUTH:int = 4;
		public static const WEST :int = 8;
		public static const NORTHWEST :int = NORTH | WEST;
		public static const NORTHEAST :int = NORTH | EAST;
		public static const SOUTHWEST :int = SOUTH | WEST;
		public static const SOUTHEAST :int = SOUTH | EAST;
		public static const EASTWEST  :int = EAST  | WEST;
		public static const NORTHSOUTH:int = NORTH | SOUTH;
		protected var _unbuildable:Boolean = true;
		protected var _level:Level;
		protected var _unbuildableSprite:FlxSprite;
		
		public function Tile(ParentLevel:Level, X:Number, Y:Number):void
		{
			super(X, Y);
			_level = ParentLevel;
			_unbuildableSprite = new FlxSprite(X - 10, Y - 10, ImgUnbuildable);
			_unbuildableSprite.width = _unbuildableSprite.height = 50;
			_unbuildableSprite.solid = false;
		}
		public function getDirection():Number { return 0; }
		override public function render():void {
			super.render();
			if (_level.ui.typeSelected != null && _unbuildable) {
				_unbuildableSprite.render();
			}
		}
		public function get centerX():int {
			return x + width / 2;
		}
		public function get centerY():int {
			return y + height/2;
		}
	}

}