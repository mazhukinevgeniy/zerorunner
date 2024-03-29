package view.shell 
{
	import binding.IBinder;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.layout.VerticalLayout;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import view.shell.controls.Background;
	import view.shell.events.ShellEvent;
	import view.utils.createNavigatorListener;
	
	public function initializeShell(shellRoot:DisplayObjectContainer, 
	                                gameRoot:DisplayObjectContainer,
									binder:IBinder):void
	{
		shellRoot.addChild(new Background(binder));
		
		
		var navigator:ScreenNavigator = new ScreenNavigator();
		navigator.addEventListener(Event.CHANGE, createNavigatorListener(binder));
		
		shellRoot.addChild(navigator);
		
		
		var mainScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new MainMenuScreen(binder), getMainEventMap(), getDefaultProperties());
		
		var optionsScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new OptionsScreen(binder), getDefaultEventMap(), getDefaultProperties());
		
		var memoriesScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(new MemoriesScreen(binder), getDefaultEventMap(), getDefaultProperties());
		
		var creditsScreen:ScreenNavigatorItem = 
			new ScreenNavigatorItem(CreditsScreen, getDefaultEventMap(), getDefaultProperties());
		
		
		navigator.addScreen(View.SHELL_SCREEN_MAIN, mainScreen);
		navigator.addScreen(View.SHELL_SCREEN_OPTIONS, optionsScreen);
		navigator.addScreen(View.SHELL_SCREEN_MEMORIES, memoriesScreen);
		navigator.addScreen(View.SHELL_SCREEN_CREDITS, creditsScreen);
		
		
		navigator.showScreen(View.SHELL_SCREEN_MAIN);
		
		
		function getMainEventMap():Object
		{
			var map:Object = { };
			
			map[ShellEvent.SHOW_CREDITS] = View.SHELL_SCREEN_CREDITS;
			map[ShellEvent.SHOW_OPTIONS] = View.SHELL_SCREEN_OPTIONS;
			map[ShellEvent.SHOW_MEMORIES] = View.SHELL_SCREEN_MEMORIES;
			
			return map;
		}
		
		function getDefaultEventMap():Object
		{
			var map:Object = { };
			
			map[ShellEvent.SHOW_MAIN] = View.SHELL_SCREEN_MAIN;
			
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