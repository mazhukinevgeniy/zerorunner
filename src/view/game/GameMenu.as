package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.game.IGameMenuRelated;
	import controller.observers.game.INewGameHandler;
	import feathers.controls.Button;
	import flash.display.Stage;
	import flash.geom.Point;
	import model.interfaces.IStatus;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
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
	import view.themes.GameTheme;
	
	internal class GameMenu extends Sprite implements IGameMenuRelated, 
	                                                  INewGameHandler
	{
		private var status:IStatus;
		
		private var hideToggleButton:Button;
		
		private var mainButtons:Sprite;
		
		private var quitButton:Button;
		private var mapButton:Button;
		
		private var controller:IGameController;
		
		public function GameMenu(binder:IBinder, root:DisplayObjectContainer) 
		{
			this.status = binder.gameStatus;
			this.controller = binder.gameController;
			
			super();
			
			binder.notifier.addGameStatusObserver(this);
			
			this.initializeBody(binder.assetManager.getTextureAtlas("sprites"));
			this.initializeToggle();
			
			root.addChild(this);
		}
		
		public function setVisibilityOfMenu(visible:Boolean):void
		{
			this.mainButtons.visible = visible;
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
			
			this.controller.setVisibilityOfMenu(!this.mainButtons.visible);
		}
		
		private function handleQuitTriggered(event:Event):void
		{
			event.stopPropagation();
			
			if (this.status.isGameOn())
				this.controller.gameStopped(Game.ENDING_ABANDONED);
			
			this.controller.quitGame();
		}
		
		private function handleMapTriggered(event:Event):void
		{
			event.stopPropagation();
			
			this.mainButtons.visible = false;
			this.controller.setVisibilityOfMenu(false);
			
			this.controller.setVisibilityOfMap(!this.status.isMapOn());
		}
		
		
		public function newGame():void
		{
			this.controller.setVisibilityOfMenu(false);
		}
	}

}