package com.darkdefense.ui
{
	import flash.display.Shape;
	import org.flixel.*;
	import com.darkdefense.towers.LightRadius;
	import com.darkdefense.states.Level;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class Fog extends FlxSprite
	{
		public var lightsChanged:Boolean = true;
		
		private const _DRAW_STEP:Number = 0.1;
		private const _DRAW_FRAMES:uint = 3;
		private const _DRAW_FRAMES_WORST:uint = 12;
		
		private var _drawFrames:uint = _DRAW_FRAMES;
		private var _scroll:FlxPoint;
		private var _lights:FlxGroup;
		private var _movingLights:FlxGroup;
		private var _timeSinceLastDraw:Number = 0;
		private var _framesSinceLastDraw:Number = 0;
		private static var _staticSprite:FlxSprite;
		private static var _movingSprite:FlxSprite;
		private var _init:Boolean;
		
		public function Fog(Lights:FlxGroup, MovingLights:FlxGroup = null):void 
		{
			super();
			createGraphic(FlxG.width, FlxG.height * 2, 0xff000000);
			this.blend = "multiply";
			this._lights = Lights;
			this._movingLights = MovingLights;
            this.scrollFactor = new FlxPoint(1, 1);
			_staticSprite = new FlxSprite;
			_movingSprite = new FlxSprite;
			_staticSprite.createGraphic(width, height, 0x00000000);
			_movingSprite.createGraphic(width, height, 0x00000000);
			_staticSprite.fill(0xffffffff);
			_movingSprite.fill(0xffffffff);
			_staticSprite.fill(0x00000000);
			_movingSprite.fill(0x00000000);
			this.fill(0xff000000);
		}
		
		override public function update():void {
			super.update();
			_timeSinceLastDraw += FlxG.elapsed;
			_framesSinceLastDraw++;
			if (FlxG.elapsed == FlxG.maxElapsed) {
				_drawFrames++;
				if (_drawFrames > _DRAW_FRAMES_WORST) _drawFrames = _DRAW_FRAMES_WORST;
			}
		}
		
		override public function destroy():void {
			super.destroy();
			_staticSprite = null;
			_movingSprite = null;
		}
		
		override public function render():void {
			if (lightsChanged) {
				_staticSprite.fill(0x000000000);
				for each (var l:LightRadius in _lights.members) {
					if (l != null) _staticSprite.draw(l, l.fogOffset.x, l.fogOffset.y);
				}
				if (!_init) {
					this.fill(0xff000000);
					this.draw(_staticSprite);
					_init = true;
				}
			}
			if ((_timeSinceLastDraw > _DRAW_STEP && _framesSinceLastDraw > _drawFrames) || lightsChanged) {
				if (_movingLights != null && _movingLights.countLiving() > 0) {
					_movingSprite.fill(0x00000000);
					for each (var m:LightRadius in _movingLights.members) {
						if (m != null) _movingSprite.draw(m, m.fogOffset.x, m.fogOffset.y);
					}
				}
				this.fill(0xff000000);
				this.draw(_staticSprite);
				this.draw(_movingSprite);
				_timeSinceLastDraw = 0;
				_framesSinceLastDraw = 0;
			}
			super.render();
			lightsChanged = false;
		}
		
		public function get timeSinceLastDraw():Number { return _timeSinceLastDraw; }
	}

}