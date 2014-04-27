package game.hud 
{
	import data.StatusReporter;
	import flash.display.Stage;
	import flash.geom.Point;
	import game.GameElements;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import utils.updates.IUpdateDispatcher;
	
	internal class Panel extends Sprite
	{
		private var flow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		private var menuButton:Button;
		
		public function Panel(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.status = elements.database.status;
			
			super();
			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
			this.addButtons();
			
			elements.displayRoot.addChild(this);
		}
		
		private function addButtons():void
		{
			this.menuButton = new Button(Texture.fromColor(100, 20, 0xFFCCFF33), "Quit game");
			this.menuButton.fontName = "HiLo-Deco";
			this.menuButton.fontSize = 18;
			
			this.addChild(this.menuButton);
			
			this.menuButton.x = this.menuButton.width / 10 + 10;
			this.menuButton.y = 10;
		}
		
		private function handleTrigger(event:Event):void
		{
			event.stopPropagation();
			
			if (event.target == this.menuButton)
			{
				if (this.status.isGameOn())
					this.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_ABANDONED);
				
				this.flow.dispatchUpdate(Update.quitGame);
			}
		}
		
	}

}