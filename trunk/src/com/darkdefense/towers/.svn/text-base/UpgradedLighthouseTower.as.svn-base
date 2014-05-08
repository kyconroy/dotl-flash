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
	 
	public class UpgradedLighthouseTower extends LighthouseTower
	{
		[Embed(source = "../../../assets/images/upgraded-lighthouse-tower.png")] private var ImgTower:Class;	
		private var _backWedge:LightWedge;
		
		public function UpgradedLighthouseTower(ParentLevel:Level, X:Number, Y:Number, Built:Boolean=true, Factor:Number = 1.15):void
		{
			super(ParentLevel, X, Y, false, Factor);
			_backWedge = new LightWedge(this.x, this.y, scale_by, _level, 180);
			_offset = (_backWedge.STARTING_WEDGE_DIAMETER / 2) - width/2;
			_backWedge.fogOffset.x = this.x - _offset;
			_backWedge.fogOffset.y = this.y - _offset;
			_level.movingLights.add(_backWedge);
			
			_towerImage = ImgTower;
			_towerName = "Upgraded Lighthouse Tower";
			_buildKey = "";
			_towerData = "Double Beams";
			loadGraphic(ImgTower);
			_upgradesInto = null;
			this.isUpgraded = true;
			if (Built) {
				_level.loggingEvents.addEvent("TowerUpgraded", ParentLevel.fullLevelID + "@UpgradedLighthouseTower@" + this.x + "," + this.y);
				FlxG.kong.API.stats.submit("LighthouseTowersUpgraded", 1);
			}
		}
		override public function update():void {
			super.update();
			_backWedge.update();
		}
		
		override public function kill():void {
			super.kill();
			_backWedge.kill();
			_level.movingLights.remove(_backWedge, true);
		}
	}
}