package com.darkdefense.towers 
{
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	import com.darkdefense.states.Level;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import com.darkdefense.ui.Fog;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.tiles.Tile;
	 
	public class UpgradedLanternTower extends LanternTower
	{
		[Embed(source = "../../../assets/images/upgraded-tower-light.png")] private var ImgTower:Class;	
		
		public function UpgradedLanternTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true, Factor:Number = 1.5):void
		{
			super(ParentLevel, X, Y, false, Factor);
			_buildKey = "";
			_towerImage = ImgTower;
			_towerName = "Upgraded Lantern Tower";
			_towerData = "Expanded Light";
			loadGraphic(ImgTower);
			_upgradesInto = null;
			this.isUpgraded = true;
			if (Built) {
				_level.loggingEvents.addEvent("TowerUpgraded", ParentLevel.fullLevelID + "@UpgradedLanternTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("LanternTowersUpgraded", 1);
			}
		}
	}
}