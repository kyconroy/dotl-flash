package com.darkdefense.enemies
{
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.*;
	 
	public class EnemyBase extends Tile
	{
		private var _direction:Number;
		//[Embed(source = "../../../assets/images/enemy-n.png")]  private static const ImgN :Class;
		//[Embed(source = "../../../assets/images/enemy-e.png")]  private static const ImgE :Class;
		//[Embed(source = "../../../assets/images/enemy-s.png")]  private static const ImgS :Class;
		//[Embed(source = "../../../assets/images/enemy-w.png")]  private static const ImgW :Class;
		[Embed(source = "../../../assets/images/enemy-spawn.png")]  private static const SpawnImg :Class;
		public function EnemyBase(ParentLevel:Level, X:Number, Y:Number, Direction:Number):void
		{
			super(ParentLevel, X, Y);
			this._direction = Direction;
			//switch(_direction) {
				//case NORTH:      loadGraphic(ImgN);  break;
				//case EAST:       loadGraphic(ImgE);  break;
				//case SOUTH:      loadGraphic(ImgS);  break;
				//case WEST:       loadGraphic(ImgW);  break;
			//}
			loadGraphic(SpawnImg);
			_level.unBuildable.add(this);
			_level.path.add(this);
			_level.enemyBase.push(this);
		}
		override public function getDirection():Number {
			return _direction;
		}
	}

}