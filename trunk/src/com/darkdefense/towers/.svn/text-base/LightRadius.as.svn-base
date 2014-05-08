package com.darkdefense.towers 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import com.darkdefense.tiles.Tile;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class LightRadius extends FlxSprite
	{
		[Embed(source = '../../../assets/images/light_radius.png')] private var radius:Class;
		public const STARTING_DIAMETER:int = 320;
		private const _LIGHT_PORTION:Number = .8;
		
		public var center:FlxPoint = new FlxPoint(0, 0);
		public var fogOffset:FlxPoint = new FlxPoint(0, 0);
		
		public function LightRadius(X:Number, Y:Number, Scale:Number):void
		{
			super(X - ((STARTING_DIAMETER * _LIGHT_PORTION * Scale) / 2) + (Tile.TILESIZE / 2), 
				  Y - ((STARTING_DIAMETER * _LIGHT_PORTION * Scale )/ 2) + (Tile.TILESIZE / 2));
			loadGraphic(radius, false, false, STARTING_DIAMETER, STARTING_DIAMETER);
			this.scale.x = Scale;
			this.scale.y = Scale;
			this.width = (_LIGHT_PORTION * Scale * width);
			this.height = (_LIGHT_PORTION * Scale * height);
			
			center.x = this.x + (this.width / 2);
			center.y = this.y + (this.height / 2);
		}
		
		public function checkDistance(other:FlxPoint):Boolean {
			var distance_sq:Number = 0;
			var radius_sq:Number = (this.width / 2) * (this.width / 2);
			distance_sq = ((this.center.x - other.x) * (this.center.x - other.x)) + ((this.center.y - other.y) * (this.center.y - other.y));
			return distance_sq <= radius_sq;
		}
		
	}

}