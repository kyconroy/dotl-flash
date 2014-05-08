package com.darkdefense.states.worlds 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.ui.*;
	import com.darkdefense.towers.*;
    import com.darkdefense.states.*;
	
	public class TutorialWorld extends World
	{
		[Embed(source = '../../../../assets/levels/tutorial_ui.txt', mimeType = "application/octet-stream")] private var TutorialUICode:Class;
        [Embed(source = '../../../../assets/levels/tutorial_lt.txt', mimeType = "application/octet-stream")] private var TutorialLTCode:Class;
        [Embed(source = '../../../../assets/levels/tutorial_at.txt', mimeType = "application/octet-stream")] private var TutorialATCode:Class;
        [Embed(source = '../../../../assets/levels/tutorial_up.txt', mimeType = "application/octet-stream")] private var TutorialUPCode:Class;
		
		override public function TutorialWorld(ParentWorld:World, Music:Class):void
		{
			super(ParentWorld, Music);
		}
		override public function create():void 
		{
			super.create();
			//Create the intro tutorial level
            var tutorial_ui:Level = new Level(TutorialUICode, this, this,null, false, UI.LANTERN_TOWER | UI.ARROW_TOWER, false);
            var tutorial_lt:Level = new Level(TutorialLTCode, this, this, null, false, UI.LANTERN_TOWER, false);
            var tutorial_at:Level = new Level(TutorialATCode, this, this, null, false, UI.ARROW_TOWER, false);
            var tutorial_up:Level = new Level(TutorialUPCode, this, _parent, null, false, UI.LANTERN_TOWER | UI.ARROW_TOWER, true);
					
			// Add levels.  
			addButton(tutorial_ui, null, "Game Interaction", true);
			addButton(tutorial_at, null, "Building", true);
			addButton(tutorial_lt, null, "Light Towers", true);
			addButton(tutorial_up, null, "Upgrades", true);
			//addButton(_parent, null, "Back", false);
		}
		
	}

}