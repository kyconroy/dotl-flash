package com.darkdefense.logging 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class TowerStats
	{
		public var allTowers:Dictionary;
		
		public var totalOverallTowers:Number;
		public var totalUpgradedTowers:Number;
		
		public var totalLanternTowers:Number;
		public var totalLightTowers:Number;
		public var totalUpgradedLanternTowers:Number;
		public var totalUpgradedLightTowers:Number;
		
		public var totalArrowTowers:Number;
		public var totalUpgradedArrowTowers:Number;
		
		public var totalMagicTowers:Number;
		public var totalUpgradedMagicTowers:Number;
		
		public var totalCanonTowers:Number;
		public var totalUpgradedCanonTowers:Number;
		
		public var totalLighthouseTowers:Number;
		public var totalUpgradedLighthouseTowers:Number;
		
		public function TowerStats():void 
		{
			totalArrowTowers = 0;
			totalCanonTowers = 0;
			totalMagicTowers = 0;
			totalLanternTowers = 0;
			totalLighthouseTowers = 0;
			
			totalUpgradedArrowTowers = 0;
			totalUpgradedCanonTowers = 0;
			totalUpgradedMagicTowers = 0;
			totalUpgradedLanternTowers = 0;
			totalUpgradedLighthouseTowers = 0;
			
			totalUpgradedTowers = 0;
			totalOverallTowers = 0;
			
			allTowers = new Dictionary();
			/*allTowers[totalArrowTowers] = totalArrowTowers
			allTowers[totalUpgradedArrowTowers] = totalUpgradedArrowTowers
			allTowers[totalMagicTowers] = totalMagicTowers
			allTowers[totalUpgradedMagicTowers]  = totalUpgradedMagicTowers
			allTowers[totalCanonTowers] = totalCanonTowers
			allTowers[totalUpgradedCanonTowers]  = totalUpgradedCanonTowers
			allTowers[totalLanternTowers] = totalLanternTowers
			allTowers[totalUpgradedLanternTowers] = totalUpgradedLanternTowers
			allTowers[totalLightTowers] = totalLightTowers
			allTowers[totalUpgradedLanternTowers] = totalUpgradedLanternTowers*/
			//allTowers[]
		}
		
		public function countTotalOverallTowers():Number {
			var towerArray:Array = returnTowerDataNumArray();
			var sum:Number = 0;
			for each (var i:Number in towerArray) {
				sum += i;
			}
			return sum;
		}
		
		public function countTotalNormalTowers():Number {
			return (totalArrowTowers + totalCanonTowers + totalLanternTowers + totalLighthouseTowers +
				   totalMagicTowers + totalLightTowers); 
			//make sure to get rid of the totalLightTowers once build is pushed w/o them
		}
		
		public function countTotalUpgradedTowers():Number {
			return totalUpgradedArrowTowers + totalUpgradedCanonTowers + 
				   totalUpgradedLanternTowers + totalUpgradedMagicTowers + 
				   totalUpgradedLighthouseTowers;
		}
		
		public function returnTowerDataStringArray():Array {
			return new Array("Total Overall Towers: " + totalOverallTowers, 
							 "Total Overall Upgraded Towers: " + totalUpgradedTowers, 
							 "Total Arrow Towers Built: " + totalArrowTowers, 
							 "Total Cannon Towers Built: " + totalCanonTowers, 
							 "Total Magic Towers Built: " + totalMagicTowers, 
							 "Total Lantern Towers Built: " + totalLanternTowers,
							 "Total Upgraded Arrow Towers Built: " + totalUpgradedArrowTowers, 
							 "Total Upgraded Canon Towers Built: " + totalUpgradedCanonTowers, 
							 "Total Upgraded Magic Towers Built: " + totalUpgradedMagicTowers,
							 "Total Upgraded Lantern Towers Built: " + totalUpgradedLanternTowers);
		}
		
		public function returnTowerDataNumArray():Array {
			return new Array(totalOverallTowers, totalUpgradedTowers, totalArrowTowers,
				totalCanonTowers, totalMagicTowers, totalLanternTowers, totalUpgradedArrowTowers, totalUpgradedCanonTowers,
				totalUpgradedMagicTowers, totalUpgradedLanternTowers);
		}
		
		public function returnTowersAsString():Array {
			return new Array("Arrow Towers", "Cannon Towers", "Magic Towers", "Lantern Towers", "Lighthouse Towers"); 
		}
		
		public function returnFormattedTowerDataForAnalytics():String {
			return "ArrowTowers@" + totalArrowTowers + ", " + totalUpgradedArrowTowers
				 + "|MagicTowers@" + totalMagicTowers + ", " + totalUpgradedMagicTowers
				 + "|CannonTowers@" + totalCanonTowers + ", " + totalUpgradedCanonTowers
				 + "|LanternTowers@" + totalLanternTowers + ", " + totalUpgradedLanternTowers
				 + "|LighthouseTowers@" + totalLighthouseTowers + ", " + totalUpgradedLighthouseTowers
				 + "|TotalTowers@" + countTotalOverallTowers() + ", " + countTotalUpgradedTowers();
		}
		
	}

}