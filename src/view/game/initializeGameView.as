package view.game 
{
	import binding.IBinder;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import view.game.events.GameEvent;
	import view.game.renderer.Renderer;
	import view.utils.createNavigatorListener;
	
	public function initializeGameView(binder:IBinder, root:DisplayObjectContainer):void
	{
		new Renderer(binder, root);
		
		var navigator:ScreenNavigator = new ScreenNavigator();
		navigator.addEventListener(Event.CHANGE, createNavigatorListener(binder));
		
		root.addChild(navigator);
		
		
		var observerScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new ScreenObserver(binder, navigator), getObserverEventMap());
		
		var menuScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new GameMenuScreen(binder), getMenuEventMap());
		
		var mapScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new MapScreen(binder));
		
		var winGameScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new EndGameScreen(binder, Game.ENDING_WON));
		
		var loseGameScreen:ScreenNavigatorItem =
			new ScreenNavigatorItem(new EndGameScreen(binder, Game.ENDING_LOST));
		
		
		navigator.addScreen(View.GAME_SCREEN_OBSERVER, observerScreen);
		navigator.addScreen(View.GAME_SCREEN_MENU, menuScreen);
		navigator.addScreen(View.GAME_SCREEN_MAP, mapScreen);
		navigator.addScreen(View.GAME_SCREEN_WON, winGameScreen);
		navigator.addScreen(View.GAME_SCREEN_LOST, loseGameScreen);
		
		navigator.showScreen(View.GAME_SCREEN_OBSERVER);
		
		
		
		function getObserverEventMap():Object
		{
			var map:Object = { };
			
			map[GameEvent.SHOW_MENU] = View.GAME_SCREEN_MENU;
			
			return map;
		}
		
		function getMenuEventMap():Object
		{
			var map:Object = { };
			
			map[GameEvent.SHOW_MAP] = View.GAME_SCREEN_MAP;
			
			return map;
		}
	}
	
}