package  com.darkdefense.tiles
{
	import com.darkdefense.states.Level;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class WaterTile extends Tile
	{
		[Embed(source = "../../../assets/images/water1.png")] private static const Water1:Class;
		[Embed(source = "../../../assets/images/water2.png")] private static const Water2:Class;
		
		[Embed(source = "../../../assets/images/water-n.png")] private static const WaterN:Class;
		[Embed(source = "../../../assets/images/water-e.png")] private static const WaterE:Class;
		[Embed(source = "../../../assets/images/water-s.png")] private static const WaterS:Class;
		[Embed(source = "../../../assets/images/water-w.png")] private static const WaterW:Class;
		
		[Embed(source = "../../../assets/images/water-ne.png")] private static const WaterNE:Class;
		[Embed(source = "../../../assets/images/water-nw.png")] private static const WaterNW:Class;
		[Embed(source = "../../../assets/images/water-se.png")] private static const WaterSE:Class;
		[Embed(source = "../../../assets/images/water-sw.png")] private static const WaterSW:Class;
		
		private const _FADE_WIDTH:uint = 7;
		
		public function WaterTile(ParentLevel:Level, X:Number, Y:Number):void
		{
			super(ParentLevel, X, Y);
			_level.waterCorners.add(new FlxSprite(X - Tile.TILESIZE, Y - Tile.TILESIZE, WaterNW));
			_level.waterCorners.add(new FlxSprite(X + Tile.TILESIZE, Y - Tile.TILESIZE, WaterNE));
			_level.waterCorners.add(new FlxSprite(X - Tile.TILESIZE, Y + Tile.TILESIZE, WaterSW));
			_level.waterCorners.add(new FlxSprite(X + Tile.TILESIZE, Y + Tile.TILESIZE, WaterSE));
			
			_level.waterEdges.add(new FlxSprite(X, Y - Tile.TILESIZE, WaterN));
			_level.waterEdges.add(new FlxSprite(X, Y + Tile.TILESIZE, WaterS));
			_level.waterEdges.add(new FlxSprite(X + Tile.TILESIZE, Y, WaterE));
			_level.waterEdges.add(new FlxSprite(X - Tile.TILESIZE, Y, WaterW));
			width = height = TILESIZE;
			if (FlxU.random() < 0.5) {
				loadGraphic(Water1);
			} else {
				loadGraphic(Water2);
			}
			_level.unBuildable.add(this);
			_level.otherTiles.add(this);
		}
	}

}