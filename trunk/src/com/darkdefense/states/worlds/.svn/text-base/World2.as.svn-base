package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.states.World;
	import com.darkdefense.ui.UI;
	import com.darkdefense.towers.*;
	
	public class World2 extends World
	{

		[Embed(source = '../../../../assets/sounds/Level2_Background.mp3')] private var LevelMusic:Class;
		
		[Embed(source = '../../../../assets/levels/level2-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level2-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level2-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/levels/level2-4.txt', mimeType = "application/octet-stream")] private var Level4Spec:Class;
		[Embed(source = '../../../../assets/images/Level2-1.jpg')] private var Level2_1:Class;
		[Embed(source = '../../../../assets/images/Level2-2.jpg')] private var Level2_2:Class;
		[Embed(source = '../../../../assets/images/Level2-3.jpg')] private var Level2_3:Class;
		[Embed(source = '../../../../assets/images/Level2-4.jpg')] private var Level2_4:Class;
		
		override public function World2(ParentWorld:World):void 
		{
			super(ParentWorld, LevelMusic);
		}
		override public function create():void {
			super.create();
			Level.showButtons = Level.showButtons | UI.ARROW_TOWER | UI.LANTERN_TOWER | UI.MAGIC_TOWER;
			addButton(new Level(Level1Spec, this, this, LevelMusic, null, true, 0, true), Level2_1, "Level 2 - 1");
			addButton(new Level(Level2Spec, this, this, LevelMusic, null, true, 0, true), Level2_2, "Level 2 - 2");
			addButton(new Level(Level3Spec, this, this, LevelMusic, null, true, 0, true), Level2_3, "Level 2 - 3");
			addButton(new Level(Level4Spec, this,
								this, LevelMusic, new TowerUnlockWorld(CannonTower, UI.CANNON_TOWER, _parent), true, 0, true), Level2_4, "Level 2 - 4");
		}
	
	} // End Class
}