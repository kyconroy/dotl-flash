package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.World;
	import com.darkdefense.states.Level;
    import com.darkdefense.ui.UI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class World4 extends World
	{
		
		[Embed(source = '../../../../assets/sounds/Level4_Background.mp3')] private var LevelMusic:Class;
		
		[Embed(source = '../../../../assets/levels/level4-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level4-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level4-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/levels/level4-4.txt', mimeType = "application/octet-stream")] private var Level4Spec:Class;
        [Embed(source = '../../../../assets/levels/level4-5.txt', mimeType = "application/octet-stream")] private var Level5Spec:Class;
		[Embed(source = '../../../../assets/images/Level4-1.jpg')] private var Level4_1:Class;
		[Embed(source = '../../../../assets/images/Level4-2.jpg')] private var Level4_2:Class;
		[Embed(source = '../../../../assets/images/Level4-3.jpg')] private var Level4_3:Class;
		[Embed(source = '../../../../assets/images/Level4-4.jpg')] private var Level4_4:Class;
		[Embed(source = '../../../../assets/images/Level4-5.jpg')] private var Level4_5:Class;
		
		
		override public function World4(ParentWorld:World):void
		{
			super(ParentWorld, LevelMusic);
		}
		
		override public function create():void {
			super.create();
            Level.showButtons |= 0xff; 
			Level.showUpgrade = true;
			addButton(new Level(Level1Spec, this, this, LevelMusic), Level4_1, "Level 4 - 1");
			addButton(new Level(Level2Spec, this, this, LevelMusic), Level4_2, "Level 4 - 2");
			addButton(new Level(Level3Spec, this, this, LevelMusic), Level4_3, "Level 4 - 3");
			addButton(new Level(Level4Spec, this, this, LevelMusic), Level4_4, "Level 4 - 4");
            addButton(new Level(Level5Spec, this, _parent, LevelMusic), Level4_5, "Level 4 - 5");
		}
	}

}