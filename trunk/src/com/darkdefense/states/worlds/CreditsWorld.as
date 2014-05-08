package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.World;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.UI;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxG;

	public class CreditsWorld extends World
	{	
		private var _credits:FlxGroup;
		
		override public function CreditsWorld(ParentWorld:World):void
		{
			super(ParentWorld, null, "Credits", true);
		}
		
		override public function create():void {
			super.create();
			_playbutton.visible = false;
			_playbutton.active = false;
			_scoreText.visible = false;
			_baseScoreText.visible = false;
			_goalText.visible = false;
			_baseGoalText.visible = false;
			
			_credits = new FlxGroup();
			
			var titleColor:uint = 0xffFF9900;
			var txtColor:uint = 0xffFFFFFF;
			var txtFont:String = "diavlo"
			var txt:FlxText;
			
			txt = new FlxText(0, 3 * Tile.TILESIZE, FlxG.width, "Thanks for Playing!");
			txt.setFormat(txtFont, UI.txtSize(1), titleColor, "center");
			this.add(txt);
		
			_credits.y = FlxG.height - 5 * Tile.TILESIZE;
			_credits.velocity.y = - 30;
			
			var txtWidth:Number = 9 * Tile.TILESIZE
			txt = new FlxText((FlxG.width - txtWidth)/2, 0, txtWidth, 
			 "This game produced by students in the University of Washington CSE Games Capstone, Spring 2010\n\n"
			 
			+"Katherine Allaway\n"
			+"Kyle Conroy\n"
			+"Jacob Masaki\n"
			+"David Truong\n"
			
			+"\n\n"
			
			+"With special thanks to Marianne Lee for Art Design!\n\n"
			
			+"and thanks to Sean Ren.\n\n"
			
			+"Music and sounds from FreeSound.org.\n\n"
			
			+"Copyright Katherine Allaway, Kyle Conroy, Jacob Masaki, David Truong, Marianne Lee, Sean Ren 2010." );
			txt.setFormat(txtFont, UI.txtSize(0.5), txtColor, "center");
			_credits.add(txt);
		}
		override public function update():void {
			super.update();
			_credits.update();
			_mapButton.visible = true;
			_mapButton.active = true;
		}
		
		override public function render():void {
			_backgroundSprite.render();
			_credits.render();
			_fog.render();
			defaultGroup.render();
		}
	
		
	} // End Class.  
}