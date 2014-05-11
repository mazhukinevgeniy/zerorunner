package view.shell 
{
	import binding.IBinder;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import view.shell.controls.Background;
	import view.shell.events.ShellEvent;
	
	public function initializeShell(shellRoot:DisplayObjectContainer, 
	                                gameRoot:DisplayObjectContainer,
									binder:IBinder):void
	{
		shellRoot.addChild(new Background());
		
		
		var navigator:ScreenNavigator = new ScreenNavigator();
		
		shellRoot.addChild(navigator);
		
		
		var mainScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new MainScreen(binder), getMainEventMap());
		
		var optionsScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new OptionsScreen(binder));
		
		var trophiesScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(TrophiesScreen);
		
		var creditsScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(CreditsScreen);
		
		
		navigator.addScreen(View.SCREEN_MAIN, mainScreen);
		navigator.addScreen(View.SCREEN_OPTIONS, optionsScreen);
		navigator.addScreen(View.SCREEN_TROPHIES, trophiesScreen);
		navigator.addScreen(View.SCREEN_CREDITS, creditsScreen);
		
		
		navigator.showScreen(View.SCREEN_MAIN);
		
		
		function getMainEventMap():Object
		{
			var map:Object = { };
			
			map[ShellEvent.SHOW_CREDITS] = View.SCREEN_CREDITS;
			map[ShellEvent.SHOW_OPTIONS] = View.SCREEN_OPTIONS;
			map[ShellEvent.SHOW_TROPHIES] = View.SCREEN_TROPHIES;
			
			return map;
		}
		
		//TODO: allow the return from every screen
	}
	
}