package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.World;
	import com.darkdefense.states.Level;
    import com.darkdefense.ui.UI;
	
	/**
	 * ...
	 * @author David Truong
	 */
	public class World5 extends World
	{
		[Embed(source = '../../../../assets/sounds/Level5_Background.mp3')] private var LevelMusic:Class;
		
		[Embed(source = '../../../../assets/levels/level5-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level5-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level5-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/levels/level5-4.txt', mimeType = "application/octet-stream")] private var Level4Spec:Class;
		[Embed(source = '../../../../assets/images/Level5-1.jpg')] private var Level5_1:Class;
		[Embed(source = '../../../../assets/images/Level5-2.jpg')] private var Level5_2:Class;
		[Embed(source = '../../../../assets/images/Level5-3.jpg')] private var Level5_3:Class;
		[Embed(source = '../../../../assets/images/Level5-4.jpg')] private var Level5_4:Class;

		
		
		override public function World5(ParentWorld:World):void
		{
			super(ParentWorld, LevelMusic);
		}
		
		override public function create():void {
			super.create();
            Level.showButtons |= 0xff; 
			Level.showUpgrade = true;
			addButton(new Level(Level1Spec, this, this, LevelMusic), Level5_1, "Level 5 - 1");
			addButton(new Level(Level2Spec, this, this, LevelMusic), Level5_2, "Level 5 - 2");
			addButton(new Level(Level3Spec, this, this, LevelMusic), Level5_3, "Level 5 - 3");
			addButton(new Level(Level4Spec, this, this, LevelMusic), Level5_4, "Level 5 - 4");
		}
	}
}