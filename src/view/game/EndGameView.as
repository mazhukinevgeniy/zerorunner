package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.IGameStopHandler;
	import controller.observers.INewGameHandler;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import view.themes.GameTheme;
	
	internal class EndGameView extends InGameWindowBase implements INewGameHandler,
	                                                               IGameStopHandler
	{
		private var text:Label;
		
		private var controller:IGameController;
		
		public function EndGameView(binder:IBinder, root:DisplayObjectContainer) 
		{
			this.controller = binder.gameController;
			
			super(200, 200, binder.assetManager.getTextureAtlas("sprites"));
			
			
			this.text = new Label();
			this.text.x = 20;
			this.text.y = 20;
			this.addChild(this.text);
			
			
			var button:Button = new Button();
			button.nameList.add(GameTheme.MENU_BUTTON);
			button.nameList.add(GameTheme.QUIT_GAME);
			
			button.x = 60;
			button.y = 60;
			this.addChild(button);
			
			button.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			binder.notifier.addObserver(this);
			
			root.addChild(this);
		}
		
		public function newGame():void
		{
			this.visible = false;
		}
		
		public function gameStopped(reason:int):void
		{
			if (reason != Game.ENDING_ABANDONED)
			{
				this.visible = true;
				
				if (reason == Game.ENDING_WON)
				{
					this.text.text = "You win!";
				}
				else if (reason == Game.ENDING_LOST)
				{
					this.text.text = "You lose!";
				}
			}
		}
		
		private function handleQuitTriggered():void
		{
			this.controller.quitGame();
		}
	}

}