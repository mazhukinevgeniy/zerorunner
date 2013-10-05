package ui.navigation 
{
	import flash.display.Stage;
	import flash.geom.Point;
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
	
	public class Panel extends Sprite
	{
		private var flow:IUpdateDispatcher;
		
		private var menuButton:Button;
		
		public function Panel(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
			
			this.addButtons();
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
				this.flow.dispatchUpdate(Update.gameStopped);
				this.flow.dispatchUpdate(Update.quitGame);
			}
		}
		
	}

}