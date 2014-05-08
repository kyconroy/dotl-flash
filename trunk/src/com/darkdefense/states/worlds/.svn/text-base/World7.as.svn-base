package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.World;
	import com.darkdefense.states.Level;
    import com.darkdefense.ui.UI;
	
	/**
	 * ...
	 * @author David Truong
	 */
	public class World7 extends World
	{		
		[Embed(source = '../../../../assets/sounds/Level6_Background.mp3')] private var LevelMusic:Class;
		
		[Embed(source = '../../../../assets/levels/level7-1.txt', mimeType = "application/octet-stream")] private var Level1Spec:Class;
		[Embed(source = '../../../../assets/levels/level7-2.txt', mimeType = "application/octet-stream")] private var Level2Spec:Class;
		[Embed(source = '../../../../assets/levels/level7-3.txt', mimeType = "application/octet-stream")] private var Level3Spec:Class;
		[Embed(source = '../../../../assets/images/Level7-1.jpg')] private var Level6_1:Class;
		[Embed(source = '../../../../assets/images/Level7-2.jpg')] private var Level6_2:Class;
		[Embed(source = '../../../../assets/images/Level7-3.jpg')] private var Level6_3:Class;
		
		override public function World6(ParentWorld:World):void
		{
			super(ParentWorld, LevelMusic);
		}
		
		override public function create():void {
			super.create();
            Level.showButtons |= 0xff; 
			Level.showUpgrade = true;
			addButton(new Level(Level1Spec, this, this, LevelMusic), Level7_1, "Level 7 - 1");
			addButton(new Level(Level2Spec, this, this, LevelMusic), Level7_2, "Level 7 - 2");
			addButton(new Level(Level3Spec, this, this, LevelMusic), Level7_3, "Level 7 - 3");
		}
	}

}