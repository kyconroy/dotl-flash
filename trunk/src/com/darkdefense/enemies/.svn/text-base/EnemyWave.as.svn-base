package com.darkdefense.enemies
{
	import adobe.utils.ProductManager;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.*;
	import com.darkdefense.ui.*;
    import flash.media.SoundLoaderContext;
	import org.flixel.data.FlxAnim;
    import org.flixel.data.FlxPanel;
	import org.flixel.FlxG;
    import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxU;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Jacob Masaki
	 */
	public class EnemyWave extends FlxSprite
	{
		
		public var defeated:Boolean = false;
		public var messageHead:TutorialPopup;
		public var messageTail:TutorialPopup;
        public var thunk:Function;
        public var prev:EnemyWave;
		public var next:EnemyWave;
		public var lastRealWave:EnemyWave;
		
		private const _SPAWNDELAY:Number = 2;
		private var _base:EnemyBase;
		private var _level:Level;
		private var _timer:Number;
		private var _realWave:Boolean;
		private var _code:String;
		private var _waveStarted:Boolean;
		private var _enemyHP:int;
		private var _enemies:FlxGroup;
		private var _currentSprite:FlxSprite;
		[Embed("../../../assets/images/enemy-active.png")] private var ImgActive:Class;
		[Embed("../../../assets/images/enemy-inactive.png")] private var ImgInactive:Class;
		[Embed("../../../assets/images/enemy-defeated.png")] private var ImgDefeated:Class;
		[Embed("../../../assets/sounds/wave-start.mp3")] private var StartSound:Class;
		// Not to be confused with the booleans with similar names!  
		private var _active:FlxSprite;
		private var _inactive:FlxSprite;
		private var _defeated:FlxSprite;
		private var _dispX:Number;
		private var _dispY:Number;
        private var _locPoint:FlxObject;
		public function EnemyWave(ParentLevel:Level, Code:String):void
		{
			super();
			this.width = this.height = FlxU.ceil(0.66 * Tile.TILESIZE);
			this._level = ParentLevel;
			if (Code.charAt(0) != "@") throw Error("Illegal wave spec!");
			this._code = Code.substring(1);
			
			var time:String = _code.split(" ")[0].split(",")[0];
			var life:String = _code.split(" ")[0].split(",")[1];
			var baseIndex:int = parseInt(_code.split(" ")[0].split(",")[2]);
			this._base = _level.enemyBase[baseIndex];
			
			var enemies:String = _code.split(" ")[1];
			_timer = parseFloat(time);
			_level.goalTime += _timer;
			_enemyHP = parseFloat(life);
			if (enemies != null) {
				//this.dead = true;
				if (_timer != 0) {
					ParentLevel.totalWaveNum++;
					_realWave = true;
				} else if (ParentLevel.waveHead == null || ParentLevel.waveHead._realWave == false) {
					ParentLevel.totalWaveNum++;
					_realWave = true;
				}
			}
			if (_realWave) {
				_dispX = _level.ui.enemyX + _level.createdWaves * this.width;
				_dispY = _level.ui.enemyY;
				_level.createdWaves++;
				// Line wrap!
				if (_level.createdWaves > 10) { 
					_dispX -= 10 * this.width;
					_dispY += this.height;
				}
				_inactive = new FlxSprite(_dispX, _dispY, ImgInactive);
				_active = new FlxSprite(_dispX, _dispY, ImgActive);
				_defeated = new FlxSprite(_dispX, _dispY, ImgDefeated);
				_inactive.scrollFactor =
				_active.scrollFactor =
				_defeated.scrollFactor = 
				this.scrollFactor = new FlxPoint(0, 0);
				_currentSprite = _inactive;
				_level.ui.add(this);
				
			}
			active = false;
			_waveStarted = false;
			_code = _code.split(" ")[1];
			_enemies = new FlxGroup;
		}
		
		override public function update():void {
			//tooltip for next wave countdown
            if (_currentSprite != null) {
				var tooltipText:String = null;
                if ((_currentSprite.x <= FlxG.mouse.x) && 
				    (_currentSprite.y <= FlxG.mouse.y) && 
					((_currentSprite.y + _currentSprite.height) >= FlxG.mouse.y) &&
					(_currentSprite == _inactive))
				{
                    if (_timer > 0 && !_waveStarted) {
                        tooltipText = "Next wave in " +  FlxU.ceil(_timer);
                    }
                } else if (_currentSprite.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y)) {
					if (_currentSprite == _active) tooltipText = "Wave is active.";
					if (_currentSprite == _defeated) tooltipText = "Wave is defeated.";
				}
				if (tooltipText != null) {
					_level.ui.showToolTip(FlxG.mouse.x - Tile.TILESIZE + FlxG.mouse.cursor.width,
										  FlxG.mouse.y + 0.75 * FlxG.mouse.cursor.height, 
										  tooltipText, 0.8);
				}
            }
			if (!active) return;
			_timer -= _level.enemySpeed * FlxG.elapsed;
            
			if (_code == null) { 
				if (_timer <= 0) {
					if (thunk != null) thunk();
					if (messageHead != null) {
						messageHead.start(next);
						this.defeated = true;
					}
					else if (next != null) {
						next.start();
						this.defeated = true;
					}
				}
				return;
			}
			if (_code.length == 0) {
				if (next != null) {
                    next.realWave = true;
                    next.start();
                }
				if (_realWave && _enemies.countLiving() == 0) {
					defeated = true;
					_currentSprite = _defeated;
					if (next != null) { 
                        next.realWave = true;
                        next.startWave();
                    }
					else if (_level.enemies.countLiving() == 0){
						_level.playerWon = true;
						_level.levelOver = true;
					}
					return;
				}
			}
			if (_timer <= 0) {
				if (!_waveStarted) startWave();
				var e:Enemy = makeEnemy(_code.charAt(0), _enemyHP, _level.enemyCount);
				_level.enemyCount++;
				addEnemy(e);
				_code = _code.substring(1);
				_timer = _SPAWNDELAY;
                if (!_realWave) _timer -= 1; // Hack to fix fake waves.  
			}
			if (_waveStarted) {
				if (_currentSprite != _active) FlxG.play(StartSound);
				_currentSprite = _active; 				// Wave is active!  
			}
			else _currentSprite = _inactive;            // Not so much.
            
		}
		
        private function addEnemy(e:Enemy):void {
            if (_realWave || prev == null) _enemies.add(e);
            else {
                prev.addEnemy(e);
            }
        }
        
		private function makeEnemy(s:String, hp:Number, id:int):Enemy {
			_level.goalTime++;
			switch(s) {
				case "a": return new EnemyA(_base, hp, id, _level);
				case "A": return new EnemyA(_base, hp, id, _level, Enemy.SHROUD_DURATION);
				case "b": return new EnemyB(_base, hp, id, _level);
				case "B": return new EnemyB(_base, hp, id, _level, Enemy.SHROUD_DURATION);
				case "c": return new EnemyC(_base, hp, id, _level);
				case "C": return new EnemyC(_base, hp, id, _level, Enemy.SHROUD_DURATION);
				default: return null;
			}
		}
		
		public function start():void {
			this.active = true;
		}
		public function startWave():void {
			this.active = true;
			if (this.messageHead != null) { messageHead.start(this.next); }
            if (this.thunk != null) { 
                thunk();
                thunk = null;
            }
			if (this._waveStarted == false)
			{
				_timer = 0;
				if (_realWave) _level.waveNum++;
				this._waveStarted = true;
			}
		}
		public function stop():void {
			this.active = false;
		}
		override public function render():void {
			if (_currentSprite == null) return;
			_currentSprite.render();
		}
		override public function toString():String {
			var ret:String = "EnemyWave: "+_enemyHP;
			if (_code != null) ret += ": "+_code;
			return ret;
		}
		override public function destroy():void {
			super.destroy();
			thunk = null;
			messageHead = null;
			messageTail = null;
		}
        
        public function get realWave():Boolean { return _realWave; }
        
        public function set realWave(value:Boolean):void 
        {
            _realWave = value;
        }
	}
}