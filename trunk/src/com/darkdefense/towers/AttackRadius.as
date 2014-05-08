package com.darkdefense.towers 
{
	import org.flixel.*;
	import com.darkdefense.tiles.Tile;
    import flash.display.Shape;
	/**
	 * ...
	 * @author David
	 */
	public class AttackRadius extends FlxSprite
	{
		//[Embed(source = '../../../assets/images/show_radius.png')] private var radius:Class;
		public const STARTING_DIAMETER:int = 320;
		
		protected var drawShape:Shape;
		public var X:Number;
		public var Y:Number;
		private var _range:Number;
		
		public function AttackRadius(X:Number, Y:Number, range:Number):void 
		{
			super(X - ((STARTING_DIAMETER * range) / 2) + (Tile.TILESIZE / 2), 
				  Y - ((STARTING_DIAMETER * range)/ 2) + (Tile.TILESIZE / 2));

            this._range = range;
			this.X = X+Tile.TILESIZE/2;
			this.Y = Y+Tile.TILESIZE/2;
		}
		
		override public function render():void
		{
		   super.render();
		   if (visible) {
			   var myShape:Shape = new Shape();
			   myShape.graphics.lineStyle(1,0x7FFF00);

			   myShape.graphics.drawCircle(X, Y,_range);
			   FlxG.buffer.draw(myShape);
		   }
		}
        
        public function updateLocation(newX:Number, newY:Number):void 
        {
            this.X = X;
            this.Y = Y;
        }
		
	}

}