package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.IGameMenuRelated;
	import controller.observers.IGameStopHandler;
	import controller.observers.IMapStatusObserver;
	import controller.observers.INewGameHandler;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import starling.events.Event;
	import view.game.events.GameEvent;
	import view.themes.GameTheme;
	
	internal class ScreenObserver extends Screen implements INewGameHandler, IGameStopHandler, IGameMenuRelated, IMapStatusObserver
	{
		private var gameEvents:Object = { }
		private var navigator:ScreenNavigator;
		
		private var controller:IGameController;
		
		
		private var menuButton:Button;
		
		public function ScreenObserver(binder:IBinder, navigator:ScreenNavigator) 
		{
			this.navigator = navigator;
			this.controller = binder.gameController;
			
			this.gameEvents[GameEvent.SHOW_MENU] = View.GAME_SCREEN_MENU;
			this.gameEvents[GameEvent.SHOW_OBSERVER] = View.GAME_SCREEN_OBSERVER;
			this.gameEvents[GameEvent.SHOW_WON] = View.GAME_SCREEN_WON;
			this.gameEvents[GameEvent.SHOW_LOST] = View.GAME_SCREEN_LOST;
			this.gameEvents[GameEvent.SHOW_MAP] = View.GAME_SCREEN_MAP
			
			this.initializeToggle();
			
			binder.notifier.addObserver(this);
		}
		
		
		private function initializeToggle():void
		{
			this.menuButton = new Button();
			this.menuButton.name = GameTheme.MENU_TOGGLE;
			
			this.addChild(this.menuButton);
			
			this.menuButton.x = 10;
			this.menuButton.y = 10;
			
			this.menuButton.addEventListener(Event.TRIGGERED, this.handleMenuButtonTriggered);
		}
		
		private function handleMenuButtonTriggered():void
		{
			this.controller.setVisibilityOfMenu(true);
		}
		public function newGame():void
		{
			this.controller.setVisibilityOfMenu(false);
		}
		
		public function gameStopped(reason:int):void
		{
			if (reason != Game.ENDING_ABANDONED)
			{
				if (reason == Game.ENDING_WON)
				{
					this.forceEvent(GameEvent.SHOW_WON);
				}
				else if (reason == Game.ENDING_LOST)
				{
					this.forceEvent(GameEvent.SHOW_LOST);
				}
			}
		}
		
		public function setVisibilityOfMenu(visible:Boolean):void
		{
			if (visible)
				this.forceEvent(GameEvent.SHOW_MENU);
			else
				this.forceEvent(GameEvent.SHOW_OBSERVER);
		}
		
		public function setVisibilityOfMap(visible:Boolean):void
		{
			if (visible)
				this.forceEvent(GameEvent.SHOW_MAP);
			else
				this.forceEvent(GameEvent.SHOW_OBSERVER);
		}
		
		
		private function forceEvent(name:String):void
		{
			this.navigator.showScreen(this.gameEvents[name]);
		}
	}

}