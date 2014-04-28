package game.ui.hud 
{
	import data.StatusReporter;
	import data.viewers.GameConfig;
	import feathers.controls.Button;
	import flash.display.Stage;
	import flash.geom.Point;
	import game.GameElements;
	import game.ui.GameTheme;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Panel extends Sprite
	{
		private var flow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		private var hideToggleButton:Button;
		
		private var quitButton:Button;
		
		public function Panel(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.status = elements.database.status;
			
			super();
			
			this.initializeButtons();
			
			elements.displayRoot.addChild(this);
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.restore);
		}
		
		private function initializeButtons():void
		{
			this.hideToggleButton = new Button();
			this.hideToggleButton.name = GameTheme.TRIANGLE_TOGGLE;
			
			this.addChild(this.hideToggleButton);
			
			this.hideToggleButton.x = 30; //TODO: that's hardcode, undo it
			this.hideToggleButton.y = 10;
			
			this.hideToggleButton.addEventListener(Event.TRIGGERED, this.handleToggleTriggered);
			
			
			this.quitButton = new Button();
			this.quitButton.name = GameTheme.MENU_BUTTON;
			
			this.quitButton.label = "Quit game";
			//this.quitButton.fontName = "HiLo-Deco";
			//this.quitButton.fontSize = 18;
			//TODO: use or remove
			
			this.addChild(this.quitButton);
			
			this.quitButton.x = 20;
			this.quitButton.y = this.hideToggleButton.y + 30;
			//TODO: hc again
			
			this.quitButton.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
		}
		
		private function handleToggleTriggered(event:Event):void
		{
			event.stopPropagation();
			
			this.quitButton.visible = !this.quitButton.visible;
		}
		
		private function handleQuitTriggered(event:Event):void
		{
			event.stopPropagation();
			
			if (this.status.isGameOn())
				this.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_ABANDONED);
				
			this.flow.dispatchUpdate(Update.quitGame);
		}
		
		update function restore(config:GameConfig):void
		{
			this.quitButton.visible = false;
			
			//TODO: add more buttons and stuff
		}
	}

}