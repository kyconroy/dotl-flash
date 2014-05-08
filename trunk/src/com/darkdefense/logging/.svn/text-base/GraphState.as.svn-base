package com.darkdefense.logging 
{
	import com.darkdefense.states.GameState;
	import org.flixel.*
	import org.flixel.data.FlxFade;
	/**
	 * ...
	 * @author Katherine Allaway
	 */
	public class GraphState extends GameState
	{
		private var _titleText:FlxText;
		private var _graphData:GraphData;
		public var _graphBars:FlxGroup;
		private var _nextState:FlxState;
		public var txtFont:String = "diavlo"
		public var txtColor:uint = 0xFFBFFEBF;
		
		public function GraphState(Data:GraphData, Title:String=null, nextState:FlxState = null):void 
		{
			super();
			
			var buttonwidth:Number = 120;
			var buttonheight:Number = 10;
			
			_graphData = Data;
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
				FlxG.fade.start(0xff000000, 0.5, toNextState );
			}
		}
		
		private function mainMenu():void {
			FlxG.state = _nextState;
		}
		
		private function displayGraph():void {
			_graphData.createBars(this);
		}
		private function toNextState():void {
			FlxG.state = _nextState;
		}
	}
}