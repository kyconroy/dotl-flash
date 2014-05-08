package com.darkdefense 
{
	import com.darkdefense.tiles.Tile;
	import com.darkdefense.enemies.Enemy;
	import com.darkdefense.states.Level;
	import org.flixel.FlxSprite;
	import org.flixel.*;
	/**
	 * ...
	 * @author David
	 */
	public class PlayerBase extends Tile
	{
		[Embed(source = "../../assets/images/base.png")] private var ImgBase:Class;
		[Embed(source = "../../assets/images/dirt.png")] private var ImgDirt:Class;
		[Embed(source = "../../assets/sounds/player-hit.mp3")] private var PlayerHit:Class;
		
		public var startingHP:Number;
		private var _dirt:FlxSprite;
		
		public function PlayerBase(ParentLevel:Level, X:Number, Y:Number):void
		{
			super(ParentLevel, X, Y);
			loadGraphic(ImgBase);
			fixed = true;
			_level.unBuildable.add(this);
			_level.path.add(this);
			_level.playerBase = this;
			health = _level.playerHealth;
			this.startingHP = health;
			_dirt = new FlxSprite(X, Y, ImgDirt);
			Level.backgroundSprite.add(_dirt);
		}
		
		override public function hurt(Damage:Number):void {
			this.health -= Damage;
			FlxG.play(PlayerHit);
			flicker(0.2);
			_level.ui.heartList.hurt(Damage);
			_level.loggingEvents.addEvent("PlayerHealth", "BaseDamaged");
			if (this.health <= 0 && !_level.cheat) {
				_level.playerWon = false;
				_level.levelOver = true;
			}
		}
		override public function hitTop(o:FlxObject, v:Number):void { hit(o); }
		override public function hitBottom(o:FlxObject, v:Number):void { hit(o); }
		override public function hitLeft(o:FlxObject, v:Number):void { hit(o); }
		override public function hitRight(o:FlxObject, v:Number):void { hit(o); }
		public function hit(o:FlxObject):void {
			o.kill();
			if (o is Enemy) {
				this.hurt((o as Enemy).damage);
			}
		}
		override public function update():void {
			super.update();
			FlxU.collide(this, _level.enemies);
		}
	}

}