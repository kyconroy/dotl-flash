package com.darkdefense.logging 
{
	import com.darkdefense.states.GameState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.UI;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class TowerGraphState extends GameState
	{
		private var _towerData:TowerStats;
		private var _titleText:FlxText;
		
		private var _spacing:Number = (Tile.TILESIZE * 4) / 3;
		private var _columnWidth:Number = Tile.TILESIZE * 3;
		
		private var barGroup:FlxGroup;
		private var txtGroup:FlxGroup;
		
		public function TowerGraphState(Data:TowerStats, Level:String):void 
		{
			super();
			_towerData = Data;
			barGroup = new FlxGroup();
			txtGroup = new FlxGroup();
			setTitleText(Level);
			//createBarGraphics();
			//setLabels();
		}
		
		override public function create():void {
			super.create();
			createBarGraphics();
		}
		
		override public function render():void {
			super.render();
			//setTitleText();
			barGroup.render();
			txtGroup.render();
		}
		
		private function setTitleText(Text:String):void {
			_titleText = new FlxText(0, 0, Tile.TILESIZE, Text);
			_titleText.setFormat("diavlo", UI.txtSize(0.4), 0xFFBFFEBF, "left");
			_titleText.height = Tile.TILESIZE;
			this.add(_titleText);
		}
		
		private function createBarGraphics():void {
			var startX:Number = Tile.TILESIZE / 3;
			var startY:Number = FlxG.height - Tile.TILESIZE;
			
			var yScale:Number = 0;
			
			for each(var nums:Array in _towerData.allTowers) {
				yScale += nums[1];
			}
			
			var x:Number = Tile.TILESIZE * 2;
			var w:Number = Tile.TILESIZE * 3;
			//key sprites
			var txta:FlxText = new FlxText(Tile.TILESIZE * 2, 0, Tile.TILESIZE * 3,
					"Total Towers Built = " + yScale);
			txta.setFormat("diavlo", UI.txtSize(0.4), 0xFFFFFFFF, "left");
			txtGroup.add(txta);
			
			var txtn:FlxText = new FlxText(x + w, 0, w, "Normal: ");
			txtn.setFormat("diavlo", UI.txtSize(0.4), 0xFFFFFFFF, "left");
			txtGroup.add(txtn);
			
			x = txtn.x + w;
			
			var nSprite:FlxSprite = new FlxSprite(x, 0);
			nSprite.createGraphic(Tile.TILESIZE, Tile.TILESIZE, 0xFFFF0000);
			barGroup.add(nSprite);
			
			x += (Tile.TILESIZE + (Tile.TILESIZE / 3));
			
			var txtu:FlxText = new FlxText(x, 0, w, "Upgraded: ");
			txtu.setFormat("diavlo", UI.txtSize(0.4), 0xFFFFFFFF, "left");
			txtGroup.add(txtu);
			
			x = x + w;
			
			var uSprite:FlxSprite = new FlxSprite(x, 0);
			uSprite.createGraphic(Tile.TILESIZE, Tile.TILESIZE, 0xFFFF9900);
			barGroup.add(uSprite);
			
			yScale = (FlxG.height - (Tile.TILESIZE * 2)) / yScale;
			//FlxG.log(yScale);
			
			for each(var count:Array in _towerData.allTowers) {
				var txt:FlxText = new FlxText(startX, startY, Tile.TILESIZE * 4, count[0]);
				txt.setFormat("diavlo", UI.txtSize(0.3));
				this.txtGroup.add(txt);
				
				var height:Number = count[1];
				if (height != 0) {
					var startYnorm:Number = startY - (height * yScale);
					var normBar:FlxSprite = new FlxSprite(startX, startYnorm);
					normBar.createGraphic(_columnWidth, (height * yScale), 0xFFFF0000);
					this.barGroup.add(normBar);
					this.txtGroup.add(new FlxText(startX, 
						startYnorm - (Tile.TILESIZE / 2), Tile.TILESIZE, "" + height).setFormat("diavlo", 
						UI.txtSize(0.4)));
				}
				
				height = count[2];
				if (height != 0) {
					//startX += _columnWidth;
					var startYup:Number = startY - (height * yScale);
					var upBar:FlxSprite = new FlxSprite(startX, startYup);
					upBar.createGraphic(_columnWidth, (height * yScale), 0xFFFF9900);
					this.barGroup.add(upBar);
					this.txtGroup.add(new FlxText(startX, 
							startYup - (Tile.TILESIZE / 2), Tile.TILESIZE, "" + height).setFormat("diavlo", 
							UI.txtSize(0.4)));
				}			
				
				startX += (_columnWidth + _spacing);
			}
		}		
	}
}