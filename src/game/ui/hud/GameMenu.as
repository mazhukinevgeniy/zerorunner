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
	import starling.utils.Color;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class GameMenu extends Sprite
	{
		private var flow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		private var hideToggleButton:Button;
		
		private var mainButtons:Sprite;
		
		private var quitButton:Button;
		private var mapButton:Button;
		
		public function GameMenu(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.status = elements.database.status;
			
			super();
			
			this.initializeBody(elements.assets.getTextureAtlas("sprites"));
			this.initializeToggle();
			
			elements.displayRoot.addChild(this);
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.restore);
		}
		
		private function initializeToggle():void
		{
			this.hideToggleButton = new Button();
			this.hideToggleButton.name = GameTheme.TRIANGLE_TOGGLE;
			
			this.addChild(this.hideToggleButton);
			
			this.hideToggleButton.x = 10; //TODO: that's hardcode, huh
			this.hideToggleButton.y = 10;
			
			this.hideToggleButton.addEventListener(Event.TRIGGERED, this.handleToggleTriggered);
		}
		
		private function initializeBody(atlas:TextureAtlas):void
		{
			this.mainButtons = new Sprite();
			this.addChild(this.mainButtons);
			
			var back:Quad = new Quad(Main.WIDTH, Main.HEIGHT, Color.BLACK);
			back.alpha = 0.3;
			
			this.mainButtons.addChild(back);
			
			this.mapButton = new Button();
			this.mapButton.nameList.add(GameTheme.MENU_BUTTON);
			this.mapButton.nameList.add(GameTheme.TOGGLE_MAP);
			
			this.mainButtons.addChild(this.mapButton);
			
			this.mapButton.x = 20;
			this.mapButton.y = 40;
			
			this.mapButton.addEventListener(Event.TRIGGERED, this.handleMapTriggered);
			
			
			this.quitButton = new Button();
			this.quitButton.nameList.add(GameTheme.MENU_BUTTON);
			this.quitButton.nameList.add(GameTheme.QUIT_GAME);
			
			this.mainButtons.addChild(this.quitButton);
			
			this.quitButton.x = 20;
			this.quitButton.y = this.mapButton.y + 30;
			//TODO: hc again
			
			this.quitButton.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
		}
		
		private function handleToggleTriggered(event:Event):void
		{
			event.stopPropagation();
			
			this.mainButtons.visible = !this.mainButtons.visible;
			
			this.flow.dispatchUpdate(Update.setVisibilityOfGameMenu, this.mainButtons.visible);
		}
		
		private function handleQuitTriggered(event:Event):void
		{
			event.stopPropagation();
			
			if (this.status.isGameOn())
				this.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_ABANDONED);
				
			this.flow.dispatchUpdate(Update.quitGame);
		}
		
		private function handleMapTriggered(event:Event):void
		{
			event.stopPropagation();
			
			this.mainButtons.visible = false;
			this.flow.dispatchUpdate(Update.setVisibilityOfGameMenu, false);
			
			this.flow.dispatchUpdate(Update.toggleMap);
		}
		
		
		
		
		
		update function restore(config:GameConfig):void
		{
			this.mainButtons.visible = false;
		}
	}

}