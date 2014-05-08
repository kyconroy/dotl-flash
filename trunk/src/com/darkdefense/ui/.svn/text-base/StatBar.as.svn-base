package com.darkdefense.ui
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import com.darkdefense.ui.Star;
	import com.darkdefense.tiles.Tile;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class StatBar extends FlxGroup
	{
		private var _stars:Array;
		private var _tooltipText:FlxText;
		private var _tooltipBackground:FlxSprite;
	//	private var _tooltipArea:FlxSprite;
		override public function StatBar(ui:UI, X:Number, Y:Number, Icon:Class = null, Desc:String = null):void
		{
			super();
			this.scrollFactor = new FlxPoint(0, 0);
			_stars = new Array;
			this.width = 20 + 0.15 * Tile.TILESIZE;
			this.height = 20;
			this.x = X;
			this.y = Y;
			for (var i:int = 1; i <= 5; i++) {
				var s:Star = new Star(X + i * width, Y);
				_stars.push(s);
				this.add(s);
			}
			this.width = 6 * width;
			var icon:FlxSprite = new FlxSprite(0, 0, Icon);
			icon.scrollFactor = new FlxPoint(0, 0);
			this.add(icon);
			_tooltipBackground = new FlxSprite(X + 0.75 * Tile.TILESIZE, Y + 0.25 * Tile.TILESIZE);
			_tooltipBackground.createGraphic(3.5 * Tile.TILESIZE, 0.75 * Tile.TILESIZE, 0xffdddddd);
			_tooltipBackground.alpha = 0.8;
			_tooltipBackground.scrollFactor = new FlxPoint(0, 0);
			if (ui != null) ui.tooltips.add(_tooltipBackground);
			_tooltipBackground.visible = false;
			_tooltipText = new FlxText(X + 0.65 * Tile.TILESIZE, Y + 0.3 * Tile.TILESIZE, _tooltipBackground.width, Desc);
			_tooltipText.setFormat("diavlo", UI.txtSize(0.4), 0xff000000, "center");
			_tooltipText.alpha = 0.8;
			_tooltipText.scrollFactor = new FlxPoint(0, 0);
			if (ui != null) ui.tooltips.add(_tooltipText);
			_tooltipText.visible = false;
		}
		public function setStars(N:int):void {
			for (var i:int = 0; i < 5; i++) {
				var n:int = N - i * 2;
				if (n < 0) n = 0;
				var s:Star = _stars[i] as Star;
				s.set(n);
			}
		}
		override public function update():void {
			super.update();
			if (this.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y) && this.visible) {
				_tooltipBackground.visible = true;
				_tooltipText.visible = true;
			} else {
				_tooltipBackground.visible = false;
				_tooltipText.visible = false;
			}
		}
	}

}