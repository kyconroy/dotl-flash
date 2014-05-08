package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.states.World;
	import com.darkdefense.ui.UI;
	import com.darkdefense.towers.*;
	
	public class World1 extends World
	{
		
		[Embed(source = '../../../../assets/sounds/Level1_Background.mp3')] private var LevelMusic:Class;
		
		//[Embed(source = '../../../../assets/levels/level1-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level1-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level1-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/levels/level1-4.txt', mimeType = "application/octet-stream")] private var Level4Spec:Class;
		//[Embed(source = '../../../../assets/images/Level1-1.jpg')] private var Level1_1:Class;
		[Embed(source = '../../../../assets/images/Level1-2.jpg')] private var Level1_2:Class;
		[Embed(source = '../../../../assets/images/Level1-3.jpg')] private var Level1_3:Class;
		[Embed(source = '../../../../assets/images/Level1-4.jpg')] private var Level1_4:Class;
		
		override public function World1(ParentWorld:World):void 
		{
			super(ParentWorld, LevelMusic);
		}
		override public function create():void {
			super.create();
			Level.showButtons = Level.showButtons | UI.ARROW_TOWER;
			var levelButtons:uint = 0;
			levelButtons |= UI.ARROW_TOWER;
			//addButton(new Level(Level1Spec, this, this, LevelMusic, new TowerUnlockWorld(LanternTower, UI.LANTERN_TOWER, this), true, levelButtons), Level1_1, "Level 1");
			levelButtons |= UI.LANTERN_TOWER;
			addButton(new Level(Level2Spec, this, this, LevelMusic, null, true, levelButtons), Level1_2, "Level 1");
			addButton(new Level(Level3Spec, this, this, LevelMusic, null, true, levelButtons), Level1_3, "Level 2");
			addButton(new Level(Level4Spec, this, this,
								LevelMusic, new TowerUnlockWorld(MagicTower, UI.MAGIC_TOWER, this), true, levelButtons), Level1_4, "Level 3");
		}
	
	} // End Class
}