package com.darkdefense.towers 
{
	import com.darkdefense.states.Level;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.darkdefense.ui.Fog;
	import com.darkdefense.tiles.Tile;
	/**
	 * ...
	 * @author ...
	 */
	public class LightWedge extends LightRadius
	{
		[Embed(source = '../../../assets/images/light_wedge.png')] protected var wedge:Class;
		
		private const _WEDGE_WIDTH:int = 15; // An angle.  
		public const STARTING_WEDGE_DIAMETER:int = 600;
		private var _level:Level;
		
		override public function LightWedge(X:Number, Y:Number, Scale:Number, ParentLevel:Level, Angle:Number = 0):void
		{
			super(X, Y, Scale);
			center.x = X + 0.5 * Tile.TILESIZE;
			center.y = Y + 0.5 * Tile.TILESIZE;
			loadGraphic(wedge);
			width = height = 400 * Scale;
			this.x = center.x - width / 2;
			this.y = center.y - height / 2;
			
			_level = ParentLevel;
			angle = Angle;
		}
		
		override public function update():void {
			super.update();
			angle += 20 * FlxG.elapsed * _level.enemySpeed;
			//if (_level.ui.typeSelected != null) alpha = 0.15;
			//else alpha = 1;
		}
		
		override public function checkDistance(other:FlxPoint):Boolean {
			var closeEnough:Boolean = super.checkDistance(other);
			var theta:Number = (360 + FlxU.getAngle(other.x - center.x, other.y - center.y)) % 360;
			angle = angle % 360;
			var threeQuads:Boolean = ((theta < (angle + _WEDGE_WIDTH - 90)) && (theta > (angle - _WEDGE_WIDTH -90)));
			var lastQuad:Boolean = ((theta < (angle + _WEDGE_WIDTH + 270)) && (theta > (angle - _WEDGE_WIDTH + 270)));
			return closeEnough && (threeQuads || lastQuad);
		}
	}

}