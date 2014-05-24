package view.game 
{
	import binding.IBinder;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import view.game.renderer.Renderer;
	import view.utils.createNavigatorListener;
	
	public function initializeGameView(binder:IBinder, root:DisplayObjectContainer):void
	{
		new Renderer(binder, root);
		new GameCallouts(binder, root);
		
		var navigator:ScreenNavigator = new ScreenNavigator();
		navigator.addEventListener(Event.CHANGE, createNavigatorListener(binder));
		
		new Observer(binder, navigator);
		
		root.addChild(navigator);
		
		
		var gameScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new GameScreen(binder));
		
		var menuScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new GameMenuScreen(binder));
		
		var mapScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new MapScreen(binder));
		
		var winGameScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new EndGameScreen(binder, Game.ENDING_WON));
		
		var loseGameScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new EndGameScreen(binder, Game.ENDING_LOST));
		
		
		navigator.addScreen(View.GAME_SCREEN, gameScreen);
		navigator.addScreen(View.GAME_SCREEN_MENU, menuScreen);
		navigator.addScreen(View.GAME_SCREEN_MAP, mapScreen);
		navigator.addScreen(View.GAME_SCREEN_WON, winGameScreen);
		navigator.addScreen(View.GAME_SCREEN_LOST, loseGameScreen);
		
		navigator.showScreen(View.GAME_SCREEN);
		
	}
	
}