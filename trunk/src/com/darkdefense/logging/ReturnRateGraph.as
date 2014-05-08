package com.darkdefense.logging 
{
	import com.darkdefense.logging.logItems;
	import com.darkdefense.states.GameState;
	import org.flixel.*;
	import org.flixel.data.FlxFade;
	/**
	 * ...
	 * @author David
	 */
	public class ReturnRateGraph extends GameState
	{
		private var _titleText:FlxText;
		private var _counts:Array;
		private var _title:String
		public var _graphBars:FlxGroup;
		public var txtFont:String = "diavlo"
		public var txtColor:uint = 0xFFBFFEBF;
		public var _nextState:FlxState;
		
		public function ReturnRateGraph(Title:String=null, nextState:FlxState = null):void 
		{
			_counts = logItems.plays;
			super();
			
			var buttonwidth:Number = 120;
			var buttonheight:Number = 10;
			
			//Set title text
			setTitleText(Title);
			this._graphBars = new FlxGroup();
			
			_nextState = nextState;
			
			x = 0;
			y = buttonheight*2;
			var goBack:FlxButton = new FlxButton(x, y, mainMenu);
			goBack.width = buttonwidth;
			goBack.height = buttonheight;
			goBack.loadText(new FlxText(0, 0, buttonwidth, "Main Menu").setFormat(txtFont, 16, txtColor));
			this.add(goBack);
		}
		
		override public function create():void {
			super.create();
			displayGraph();
		}
		
		public function setTitleText(Text:String):void {
			_titleText = new FlxText(0, 0, FlxG.width / 3, Text);
			_titleText.setFormat("diavlo", 16, 0xFFBFFEBF, "left");
			this.add(_titleText);
		}
		
		override public function render():void
		{
		   super.render();
		   _graphBars.render();
		}
		
		override public function update():void {
			super.update();
			
			if (FlxG.keys.justPressed("Q") && _nextState != null) {
				FlxG.fade = new FlxFade();
				FlxG.fade.start(0xff000000, 0.5, function():void { FlxG.state = _nextState; } );
			}
		}
		
		private function mainMenu():void {
			FlxG.state = _nextState;
		}
		
				
		private function displayGraph():void {
			var i:int = new Number();
			trace("displaying return rate data");
			while (_counts[i] != null) {
				trace("play return count "+i+":"+_counts[i]);
				i++;
			}
		}
	}

}