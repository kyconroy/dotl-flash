package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.World;
	import com.darkdefense.states.Level;
    import com.darkdefense.ui.UI;
	
	/**
	 * ...
	 * @author David Truong
	 */
	public class World6 extends World
	{		
		[Embed(source = '../../../../assets/sounds/Level6_Background.mp3')] private var LevelMusic:Class;
		
		[Embed(source = '../../../../assets/levels/level6-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level6-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level6-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/levels/level6-4.txt', mimeType = "application/octet-stream")] private var Level4Spec:Class;
		[Embed(source = '../../../../assets/images/Level6-1.jpg')] private var Level6_1:Class;
		[Embed(source = '../../../../assets/images/Level6-2.jpg')] private var Level6_2:Class;
		[Embed(source = '../../../../assets/images/Level6-3.jpg')] private var Level6_3:Class;
		[Embed(source = '../../../../assets/images/Level6-4.jpg')] private var Level6_4:Class;
		
		override public function World6(ParentWorld:World):void
		{
			super(ParentWorld, LevelMusic);
		}
		
		override public function create():void {
			super.create();
            Level.showButtons |= 0xff; 
			Level.showUpgrade = true;
			addButton(new Level(Level1Spec, this, this, LevelMusic), Level6_1, "Level 6 - 1");
			addButton(new Level(Level2Spec, this, this, LevelMusic), Level6_2, "Level 6 - 2");
			addButton(new Level(Level3Spec, this, this, LevelMusic), Level6_3, "Level 6 - 3");
			addButton(new Level(Level4Spec, this, this, LevelMusic), Level6_4, "Level 6 - 4");
		}
	}

}