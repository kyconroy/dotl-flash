package com.darkdefense.ui 
{
	import com.darkdefense.towers.UpgradedMagicTower;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import com.darkdefense.states.Level;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import com.darkdefense.PlayerStats;
	
	public class VolumeBar extends FlxGroup
	{
		private static const _VOL_STEP:Number = 0.1;
		private var _level:Level;
		private var _muteButton:FlxButton;
		private var _muted:FlxSprite;
		private var _unMuted:FlxSprite;
		private var _muteText:FlxText;
		private var _lastVolume:Number;
		private var _lastMute:Boolean;
		private var _volButton:FlxButton;
		private var _volSprite:FlxSprite;
		private var _fullVolWidth:Number;
		private var _init:Boolean = false;
		[Embed("../../../assets/images/volume-mute.png")] private var Muted:Class;
		[Embed("../../../assets/images/volume.png")] private var UnMuted:Class;
		[Embed("../../../assets/images/volume-bar.png")] private var VolSlider:Class;
		
		override public function VolumeBar(ParentLevel:Level = null, X:Number = 10, Y:Number = 10):void
		{
			super();
			_level = ParentLevel;
			_muteButton = new FlxButton(X, Y, onMuteClick);
			_muted = new FlxSprite(X, Y, Muted); // Apparently Flixel only sets the position of the first loaded graphic.  
			_unMuted = new FlxSprite(0, 0, UnMuted);
			_muteButton.loadGraphic(_unMuted);
			this.add(_muteButton);
			var muteText:FlxText = _muteText = new FlxText(_muteButton.width + 1, -_muteButton.height / 4, 100, "");
			_muteText.setFormat("diavlo", UI.txtSize(0.6));
			_muteButton.loadText(_muteText);
			if (_level == null) return;
			
			// We are inside a level.  
			_volSprite = new FlxSprite(0, 0, VolSlider);
			_volButton = new FlxButton(X + _muteButton.width + 2, Y, onBarClick);
			_volButton.loadGraphic(_volSprite);
			_fullVolWidth = _volSprite.width;
			this.add(_volButton);
			
			_lastVolume = FlxG.volume;
			_lastMute = FlxG.mute;
		}
		
		override public function update():void {
			super.update();
			if (_volSprite) {
				if (FlxG.volume > 0.05 && !FlxG.mute) {
					_volSprite.visible = true;
					_volSprite.loadGraphic(VolSlider, false, false, _fullVolWidth * FlxG.volume);
				}
				else {
					FlxG.mute = true;
					_volSprite.visible = false;
				}
			}
			if (FlxG.mute) {
				_muteButton.loadGraphic(_muted);
				if (_level == null) {
					_muteButton.width = _muteText.width;
					_muteText.text = "Muted";	
				}
			}
			else {
				_muteButton.loadGraphic(_unMuted);
				if (_level == null) {
					_muteButton.width = _muteText.width;
					_muteText.text = "Mute"
				}
			}
			if ((_lastVolume != FlxG.volume) || (_lastMute != FlxG.mute)) {
				PlayerStats.saveVolume();
			}
			_lastVolume = FlxG.volume;
			_lastMute = FlxG.mute;
			_init = true;
		}
		override public function render():void {
			if (!_init) return;
			super.render();
		}
		
		private function onMuteClick():void {
			if (_level == null || !_level.ui.menuButtonActive)
				FlxG.mute = !FlxG.mute;
			if (!FlxG.mute) {
				FlxG.play(DarkDefense.BeepSound);
				if(_volButton != null) _volButton.visible = true;
				if (FlxG.volume < 0.1) FlxG.volume = 0.1;
			}
			else {
				if(_volButton != null) _volButton.visible = false;
			}
		}
		private function onBarClick():void {
			FlxG.volume = FlxU.ceil(100 * ((FlxG.mouse.x - _volButton.x) / _fullVolWidth)) / 100;
			if (FlxG.volume != _lastVolume) {
				FlxG.mute = false;
				FlxG.play(DarkDefense.BeepSound);
			}
		}
		override public function destroy():void {
			super.destroy();
			_level = null;
			_muteButton = null;
			_muted = null;
			_unMuted = null;
			_muteText = null;
			_volButton = null;
			_volSprite = null;
		}
	}

}