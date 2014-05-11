package view.shell 
{
	import binding.IBinder;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.layout.VerticalLayout;
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
			new ScreenNavigatorItem(new MainMenuScreen(binder), getMainEventMap(), getDefaultProperties());
		
		var optionsScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new OptionsScreen(binder), getDefaultEventMap(), getDefaultProperties());
		
		var trophiesScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(TrophiesScreen, getDefaultEventMap(), getDefaultProperties());
		
		var creditsScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(CreditsScreen, getDefaultEventMap(), getDefaultProperties());
		
		
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
		
		function getDefaultEventMap():Object
		{
			var map:Object = { };
			
			map[ShellEvent.SHOW_MAIN] = View.SCREEN_MAIN;
			
			return map;
		}
		
		function getDefaultProperties():Object
		{
			var layout:VerticalLayout = new VerticalLayout();
			
			layout.gap = 26;
			
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			var properties:Object = { layout: layout };
			
			return properties;
		}
	}
	
}