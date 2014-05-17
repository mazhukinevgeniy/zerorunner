package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.IGameMapObserver;
	import controller.observers.IGameMenuObserver;
	import controller.observers.IGameObserver;
	import controller.observers.IGameStopHandler;
	import controller.observers.INewGameHandler;
	import feathers.controls.ScreenNavigator;
	
	internal class Observer implements INewGameHandler, IGameStopHandler, 
	                                   IGameObserver, IGameMenuObserver, 
									   IGameMapObserver
	{
		private var navigator:ScreenNavigator;
		
		private var controller:IGameController;
		
		public function Observer(binder:IBinder, navigator:ScreenNavigator) 
		{
			this.controller = binder.gameController;
			this.navigator = navigator;
			
			binder.notifier.addObserver(this);
		}
		
		
		public function gameStopped(reason:int):void
		{
			if (reason != Game.ENDING_ABANDONED)
			{
				if (reason == Game.ENDING_WON)
				{
					this.navigator.showScreen(View.GAME_SCREEN_WON);
				}
				else if (reason == Game.ENDING_LOST)
				{
					this.navigator.showScreen(View.GAME_SCREEN_LOST);
				}
			}
		}
		
		public function newGame():void
		{
			this.controller.showGame();
		}
		
		public function showGame():void
		{
			this.navigator.showScreen(View.GAME_SCREEN);
		}
		
		public function showGameMenu():void
		{
			this.navigator.showScreen(View.GAME_SCREEN_MENU);
		}
		
		public function showGameMap():void
		{
			this.navigator.showScreen(View.GAME_SCREEN_MAP);
		}
	}

}