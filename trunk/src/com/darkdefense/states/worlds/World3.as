package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.World;
	import com.darkdefense.states.Level;
	import com.darkdefense.ui.*;
	import com.darkdefense.towers.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class World3 extends World
	{
		
		[Embed(source = '../../../../assets/sounds/Level3_Background.mp3')] private var LevelMusic:Class;
		
		[Embed(source = '../../../../assets/levels/level3-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level3-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level3-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/levels/level3-4.txt', mimeType = "application/octet-stream")] private var Level4Spec:Class;
		[Embed(source = '../../../../assets/levels/level3-5.txt', mimeType = "application/octet-stream")] private var Level5Spec:Class;
		[Embed(source = '../../../../assets/images/Level3-1.jpg')] private var Level3_1:Class;
		[Embed(source = '../../../../assets/images/Level3-2.jpg')] private var Level3_2:Class;
		[Embed(source = '../../../../assets/images/Level3-3.jpg')] private var Level3_3:Class;
		[Embed(source = '../../../../assets/images/Level3-4.jpg')] private var Level3_4:Class;
		[Embed(source = '../../../../assets/images/Level3-5.jpg')] private var Level3_5:Class;
		
		
		override public function World3(ParentWorld:World):void
		{
			super(ParentWorld, LevelMusic);
		}
		
		override public function create():void {
			super.create();
			var theseButtons:uint = Level.showButtons | UI.ARROW_TOWER | UI.LANTERN_TOWER | UI.MAGIC_TOWER | UI.CANNON_TOWER
			addButton(new Level(Level1Spec, this,
								this, LevelMusic, new TowerUnlockWorld(LighthouseTower, UI.LIGHTHOUSE_TOWER, this), true, theseButtons, true), Level3_1, "Level 3 - 1");
			theseButtons |= UI.LIGHTHOUSE_TOWER;
			addButton(new Level(Level2Spec, this, this, LevelMusic, null, true, theseButtons, true), Level3_2, "Level 3 - 2");
			addButton(new Level(Level3Spec, this, this, LevelMusic, null,true, theseButtons, true), Level3_3, "Level 3 - 3");
			addButton(new Level(Level4Spec, this, this, LevelMusic, null,true, theseButtons, true), Level3_4, "Level 3 - 4");
			addButton(new Level(Level5Spec, this,
								this, LevelMusic, new TowerUnlockWorld(StarburstTower, UI.STARBURST_TOWER, _parent), true, theseButtons, true), Level3_5, "Level 3 - 5");
		}
	}

}