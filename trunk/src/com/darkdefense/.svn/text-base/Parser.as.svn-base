package com.darkdefense
{
    import adobe.utils.ProductManager;
	import com.darkdefense.enemies.EnemyWave;
	import com.darkdefense.tiles.Tile;
	import org.flixel.data.FlxAnim;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.FlxObject;
	import com.darkdefense.enemies.*;
	import com.darkdefense.tiles.*;	
	import com.darkdefense.towers.*;
	import com.darkdefense.ui.*;
	import com.darkdefense.states.Level;
	public class Parser
	{
		
		/* 
		 * Parses level spec, and stores all relevant information into ParentLevel.  
		 */
		private static var _textColor:uint = 0xFFBFFEBF;
		public static function parseLevel(ParentLevel:Level, X:Number, Y:Number, LevelSpec:Class):void {
			var levelText:String = new LevelSpec;
			var rows:Array = levelText.split("\n");
			var row:String;
			ParentLevel.bonusScore = 1;
			for (var r:uint = 0; r < rows.length; r++) {
				row = rows[r];
				if (row.charAt(0) == '#') continue;
				if (row.charAt(0) == '@') {
					parseWave(ParentLevel, row);
					continue;
				}
				if (row.charAt(0) == "$") {
						parseKeyword(ParentLevel, row);
						continue;
				}
				//added for tutorials
				if (row.charAt(0) == '!') {
					parseTutorialText(ParentLevel, row);
					continue;
				}
				for (var c:uint = 0; c < row.length - 1; c++) {
					var s:String = row.charAt(c);
					var t:FlxObject;
					if (s != ' ') { 
						addObject(ParentLevel, X + c * Tile.TILESIZE, Y + r * Tile.TILESIZE, s);
					}
				}
			}
			ParentLevel.add(ParentLevel.path);
			ParentLevel.add(ParentLevel.otherTiles);
			ParentLevel.add(ParentLevel.ltowers);
			ParentLevel.add(ParentLevel.atowers);
			ParentLevel.add(ParentLevel.waves);
			
		}
		private static function addObject(ParentLevel:Level, X:Number, Y:Number, Code:String):void {
			// Path.  
			switch(Code) {
				case '^': new PathTile(ParentLevel, X, Y, Tile.NORTH);        break;
				case '>': new PathTile(ParentLevel, X, Y, Tile.EAST);         break;
				case 'v': new PathTile(ParentLevel, X, Y, Tile.SOUTH);        break;
				case '<': new PathTile(ParentLevel, X, Y, Tile.WEST);         break;
				case 'L': new PathTile(ParentLevel, X, Y, Tile.NORTHWEST);    break;
				case 'R': new PathTile(ParentLevel, X, Y, Tile.NORTHEAST);    break;
				case 'l': new PathTile(ParentLevel, X, Y, Tile.SOUTHWEST);    break;
				case 'r': new PathTile(ParentLevel, X, Y, Tile.SOUTHEAST);    break;
				case '-': new PathTile(ParentLevel, X, Y, Tile.EASTWEST);     break;
				case '|': new PathTile(ParentLevel, X, Y, Tile.NORTHSOUTH);   break;
				// Player Base.  
				case 'P': new PlayerBase(ParentLevel, X, Y);                  break;
				// Enemy Base.  
				case 'N': new EnemyBase(ParentLevel, X, Y, Tile.NORTH);       break;
				case 'E': new EnemyBase(ParentLevel, X, Y, Tile.EAST);        break;
				case 'S': new EnemyBase(ParentLevel, X, Y, Tile.SOUTH);       break;
				case 'W': new EnemyBase(ParentLevel, X, Y, Tile.WEST);        break;
				// Light Towers.  
				case '*': new LanternTower(ParentLevel, X, Y, false);         break;
				case 'h': new LighthouseTower(ParentLevel, X, Y, false);      break;
				case 'b': new StarburstTower(ParentLevel, X, Y, false);       break;
				// Attack Towers.  
				case 'a': new ArrowTower(ParentLevel, X, Y, false);           break;
				case 'A': new UpgradedArrowTower(ParentLevel, X, Y, false);   break;
				case 'c': new CannonTower(ParentLevel, X, Y, false);          break;
				case 'C': new UpgradedCannonTower(ParentLevel, X, Y, false);  break;
				case 'm': new MagicTower(ParentLevel, X, Y, false);       	  break;
				case 'M': new UpgradedMagicTower(ParentLevel, X, Y, false);   break;
				// Other Tiles.  
				case 'w': new WaterTile(ParentLevel, X, Y);            		  break;
			}
		}
		
		private static function parseBonusScore(ParentLevel:Level, BonusCode:String):void {
			ParentLevel.bonusScore = parseInt(BonusCode.substring(1));
		}
		
		private static function parseWave(ParentLevel:Level,WaveCode:String):void {
			var wave:EnemyWave = new EnemyWave(ParentLevel, WaveCode);
			if (ParentLevel.waveHead == null) {
				ParentLevel.waveHead = wave;
			} else {
                wave.prev = ParentLevel.waveTail;
				ParentLevel.waveTail.next = wave;
			}
			ParentLevel.waveTail = wave;
			ParentLevel.waves.add(wave);
		}
		
		private static function parseTutorialText(ParentLevel:Level, TutorialCode:String):void {
			var text:TutorialPopup = new TutorialPopup(ParentLevel, TutorialCode);
			if (ParentLevel.waveTail != null) {
				if (ParentLevel.waveTail.messageHead == null) {
					ParentLevel.waveTail.messageHead = text;
				}
				else {
					ParentLevel.waveTail.messageTail.next = text;
				}
				if (ParentLevel.waveTail.messageHead.next == null)
					ParentLevel.waveTail.messageHead.next = text;
				ParentLevel.waveTail.messageTail = text;
			} else {
				if (ParentLevel.messageHead == null) ParentLevel.messageHead = text;
				else ParentLevel.messageTail.next = text;
				ParentLevel.messageTail = text;
			}
		}
        private static function parseKeyword(ParentLevel:Level, KeywordCode:String):void {
            var text:String = KeywordCode.substring(1);
			var code:String = text.split(" ")[0].substr(0, text.length - 1); // Strip off the end;  
			var args:String = text.substr(code.length);
            var thunk:Function = null;
			var tx:Number;
			var ty:Number;
            switch (code) {
                case "activate": thunk = function():void { ParentLevel.active = true };     	break;
                case "deactivate": thunk = function():void { ParentLevel.active = false };  	break;
				case "buildtimer": 
					thunk = function():void 
					{
						ParentLevel.ui.timeSinceLastBuild = parseFloat(args);
					}
					break;
				case "upgradetimer":
					thunk = function():void
					{
						ParentLevel.ui.timeSinceLastUpgrade = parseFloat(args);
					}
					break;
				case "buildspeed":
					thunk = function():void
					{
						ParentLevel.buildSpeed = parseFloat(args);
					}
					break;
				case "gamespeed":
					thunk = function():void
					{
						ParentLevel.gameSpeed = parseFloat(args);
					}
					break;
				case "upgradespeed":
					thunk = function():void
					{
						ParentLevel.upgradeSpeed = parseFloat(args);
					}
					break;
				case "enemyspeed":
					thunk = function():void
					{
						ParentLevel.enemySpeed = parseFloat(args);
					}
					break;
				case "lanterntower":
					tx = parseFloat(args.split(",")[0]) * Tile.TILESIZE;
					ty = parseFloat(args.split(",")[1]) * Tile.TILESIZE;
					thunk = function():void
					{
						new LanternTower(ParentLevel, tx, ty, false);
					}
					break;
				case "win":
					var time:Number = parseFloat(args);
					var msgText:String = args.split("|")[1];
					var pos:String = args.split(" ")[2];
					var x:Number = Tile.TILESIZE * parseFloat(pos);
					var y:Number = Tile.TILESIZE * parseFloat(pos.split(",")[1]);
					var size:Number = UI.txtSize(parseFloat(pos.split(",")[2]));
					
					thunk = function ():void {
						new TimedCallback(ParentLevel, time,
							function():void {
								ParentLevel.tutorialText.add(
									new FlxText(x, y, 20 * Tile.TILESIZE, msgText)
										.setFormat("diavlo", size, _textColor, 'left'));
								ParentLevel.tutorialText.add(
									new FlxText(0, 19 * Tile.TILESIZE, 20 * Tile.TILESIZE, "Press SPACE to continue.")
										.setFormat("diavlo", UI.txtSize(0.75), _textColor, 'center'));
								new ButtonCallback(ParentLevel, "SPACE", function():void {
									ParentLevel.parentWorld.nextLevel();
									ParentLevel.nextState.nextLevel();
									FlxG.state = ParentLevel.nextState;
								});
							})
					};
					break;
				default: thunk = function():void { FlxG.log("Fell through") }; 					break;
            }
            ParentLevel.waveTail.thunk = thunk;
        }
	}
}