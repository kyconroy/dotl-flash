package com.darkdefense.logging 
{
	import com.darkdefense.ui.UI;
	import org.flixel.*;
	import flash.display.Shape;
	import com.darkdefense.tiles.Tile;
	/**
	 * ...
	 * @author David Truong
	 */
	public class GraphBar extends FlxSprite
	{
		public var _x:Number;
		public var _y:Number;
		private var _width:Number;
		public var _height:Number;
		private var _myColor:uint;
		public var _maxValue:Number;
		
		public function GraphBar(X:Number, Y:Number, width:Number, height:Number, color:uint):void 
		{
			super( -Tile.TILESIZE, -Tile.TILESIZE);
			this._x = X;
			this._y = Y;
			this._width = width;
			this._height = height;
			this._myColor = color;
		}
		
		override public function render():void
		{
		    super.render();
		    var myShape:Shape = new Shape();
		    myShape.graphics.lineStyle(1,_myColor);

		    /*if (_maxValue != 0) {
				FlxG.log(_x+","+_y);
				//FlxG.log(_y);
				FlxG.log("h"+_height);
				FlxG.log("m"+_maxValue);*/
				
				myShape.graphics.drawRect(_x, _y, _width, -_height/_maxValue*450);
				FlxG.buffer.draw(myShape);
		}
		
		
		public function updateMax(newMax:Number):void {
			_maxValue = newMax;
		}
		
	}

}