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
	public class PathTile extends Tile
	{
		private static const _TILESIZE:int = 16;
		
		[Embed(source = "../../../assets/images/path-n.png")]  private static const ImgN :Class;
		[Embed(source = "../../../assets/images/path-e.png")]  private static const ImgE :Class;
		[Embed(source = "../../../assets/images/path-s.png")]  private static const ImgS :Class;
		[Embed(source = "../../../assets/images/path-w.png")]  private static const ImgW :Class;
		[Embed(source = "../../../assets/images/path-nw.png")] private static const ImgNW:Class;
		[Embed(source = "../../../assets/images/path-ne.png")] private static const ImgNE:Class;
		[Embed(source = "../../../assets/images/path-sw.png")] private static const ImgSW:Class;
		[Embed(source = "../../../assets/images/path-se.png")] private static const ImgSE:Class;
		[Embed(source = "../../../assets/images/path-ns.png")] private static const ImgNS:Class;
		[Embed(source = "../../../assets/images/path-ew.png")] private static const ImgEW:Class;
		
		private var _direction: int;
		private var _direction2:int;
				
		public function PathTile(ParentLevel:Level, X:Number, Y:Number, Direction:Number):void
		{
			super(ParentLevel, X, Y);
			ParentLevel.goalTime++;
			this._direction  = Direction;
			this._direction2 = 0;
			switch(_direction) {
				case NORTH:      loadGraphic(ImgN);  break;
				case EAST:       loadGraphic(ImgE);  break;
				case SOUTH:      loadGraphic(ImgS);  break;
				case WEST:       loadGraphic(ImgW);  break;
				case NORTHWEST:  loadGraphic(ImgNW);
					this._direction2 = WEST;          break;
				case NORTHEAST:  loadGraphic(ImgNE); 
					this._direction2 = EAST;          break;
				case SOUTHWEST:  loadGraphic(ImgSW); 
					this._direction2 = WEST;          break;
				case SOUTHEAST:  loadGraphic(ImgSE);
					this._direction2 = EAST;         break;
				case EASTWEST:   loadGraphic(ImgEW); 
					this._direction2 = WEST;         break;
				case NORTHSOUTH: loadGraphic(ImgNS); 
					this._direction2 = SOUTH;        break;
			}
			_level.unBuildable.add(this);
			_level.path.add(this);
		}
		/* Returns one of the four cardinal directions,
		 * For example, if this is NORTHEAST, 
		 * it will return NORTH or EAST, but not NORTHEAST. */
		override public function getDirection():Number {
			if (_direction2 != 0) {
				if (FlxU.random() > .5)
					return _direction ^ _direction2;
				else
					return _direction2;
			}
			return _direction; // No secondary direction.  
		}
	}

}