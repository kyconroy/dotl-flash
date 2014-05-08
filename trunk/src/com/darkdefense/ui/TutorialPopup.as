package com.darkdefense.ui
{
	import adobe.utils.CustomActions;
	import com.darkdefense.enemies.EnemyWave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.states.Level;
	import org.flixel.FlxG;
	import com.darkdefense.ui.*;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class TutorialPopup extends FlxText
	{	
		public var next:TutorialPopup;
		public var callback:Function;
		//private vars
		private var _level:Level;
		private var _timeRemaining:Number;
		private var _timeUntilShow:Number;
		private var _type:String;
		private var _text:String;
		private var _started:Boolean = false;
		
		//vars for text constructor
		private var _displayText:String;
		//private var _textWidth:Number; --can use this.width instead
		
		//vars for setting String format
		private var _textFont:String;
		private var _textColor:uint;
		private var _textSize:Number;
		private var _textAlign:String;
		
		private var _timed:Boolean = false;
		private var _wave:EnemyWave = null;
		private var _reminderText:FlxText;
		
		override public function TutorialPopup(ParentLevel:Level, TutorialCode:String):void 
		{
			_level = ParentLevel;
			//set the formatting variables
			this.width = 6 * Tile.TILESIZE;
			this.height = 6 * Tile.TILESIZE;
			_textFont = "diavlo"; //for now
			_textColor = 0xFFFFFFFF;
			_textSize = UI.txtSize(0.4);
			_textAlign = 'left';
			
			TutorialCode = TutorialCode.substring(1);
			
			//parse the TutorialCode string
			var timeDurString:String = TutorialCode.split(' ')[0]; //looks like this: T_start,T_duration,type
			var locString:String = TutorialCode.split(' ')[1]; //looks like this: X,Y
			var textString:String = TutorialCode.split('|')[1]; //looks like this: text|formatted|this|way in order to split on space
			
			//set private variables
			_timeUntilShow = parseFloat(timeDurString);
			_timeRemaining = parseFloat(timeDurString.split(',')[1]);
			if (_timeRemaining > 0) _timed = true;
			//_type = popupType;
			
			//parse the location string
			var xLocString:String = locString.split(',')[0];
			var yLocString:String = locString.split(',')[1];
            var txtSizeString:String = locString.split(',')[2];
			
			//set the x and y of this popup
			this.x = Tile.TILESIZE * parseFloat(xLocString);
			this.y = Tile.TILESIZE * parseFloat(yLocString);
            this._textSize = Tile.TILESIZE * parseFloat(txtSizeString);
			
			//set the private string variable
			_displayText = textString;
			
			super(x, y, width, _displayText);
			this.text = _displayText;
			setFormat(_textFont, _textSize, _textColor, _textAlign);
			this.visible = false;
			_level.tutorialText.add(this);
			if (!_timed) {
				_reminderText = new FlxText(0, 19 * Tile.TILESIZE, 20 * Tile.TILESIZE, "Press SPACE to continue.");
				_reminderText.setFormat(null, UI.txtSize(0.5), _textColor, 'center');
				_level.tutorialText.add(_reminderText);
			}
		}
		
		//start the text display, end when the timer runs out
		public function start(Wave:EnemyWave = null):void {
			_started = true;
			_wave = Wave;
		}
		
		override public function update():void { 
			super.update();
			if (!_started) return;
			if (_timed) {
				_timeUntilShow -= FlxG.elapsed * _level.enemySpeed;
				if (_timeUntilShow <= 0) {
					_timeRemaining -= FlxG.elapsed * _level.enemySpeed;
					this.visible = true;
					if (_timeRemaining < 0) {
						this.kill();
						if (next != null && next != this) {
							next.start(_wave);
						} else if (_wave != null) {
							_wave.start();
						}	
					}
				}
			} else if (FlxG.keys.justPressed("SPACE")) {
				_timed = true;
				_timeRemaining = 0.1;
			}
		}
		override public function kill():void {
			super.kill();
			if (_callback != null) _callback();
			_level.tutorialText.remove(this, true);
			if (_reminderText != null) _reminderText.kill();
			if (_reminderText != null) _level.tutorialText.remove(_reminderText, true);
		}
	}

}