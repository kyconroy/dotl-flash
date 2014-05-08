package com.darkdefense.ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import com.darkdefense.tiles.Tile;
	/**
	 * ...
	 * @author ...
	 */
	public class TiledBackground extends FlxGroup
	{
		[Embed("../../../assets/images/grass1.png")] private var Grass1:Class;
		[Embed("../../../assets/images/grass2.png")] private var Grass2:Class;
		/** 
		 * Images should be an array that contains classes that should be randomly chosen from.  
		 * 
		 * If null, Images defaults to grass.  */
		override public function TiledBackground(Images:Array=null, width:int=20, height:int=20):void 
		{
			super();
			var images:Array;
			if (Images == null) {
				images = new Array;
				images.push(Grass1);
				images.push(Grass2);
			} else {
				images = Images;
			}
			for (var tx:int = 0; tx < width; tx++) {
				for (var ty:int = 0; ty < height; ty++) {
					add(new 
						FlxSprite(tx * Tile.TILESIZE, ty * Tile.TILESIZE,
							images[FlxU.floor(FlxU.random() * images.length)]));
				}
			}
		}
		
	}

}