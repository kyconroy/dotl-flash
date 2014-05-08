package com.darkdefense.towers 
{
	import com.darkdefense.states.Level;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.PlayerStats;
	
	public class UpgradeTower extends Tower
	{
		private const UPGRADE_COOLDOWN:int = 30 *(1 - (PlayerStats.CooldownPoints * PlayerStats.COOLDOWN_BOOST));
		[Embed(source = "../../../assets/images/upgrade-button.png")] private var ImgButton:Class;	
		public override function UpgradeTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean = false):void
		{
			super(ParentLevel, X, Y, Built);
			this.width =  Tile.TILESIZE;
			this.height = Tile.TILESIZE;
			_towerImage = ImgButton;
			_buildKey = "Z";
			_time_between_builds = UPGRADE_COOLDOWN;
		}
		
	}

}