package view.shell 
{
	import binding.IBinder;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import view.shell.achievements.AchievementsWindow;
	import view.shell.credits.CreditsWindow;
	import view.shell.settings.SettingsWindow;
	
	public function initializeShell(shellRoot:DisplayObjectContainer, 
	                                gameRoot:DisplayObjectContainer,
									binder:IBinder):void
	{
		var background:Background = new Background();
		
		shellRoot.addChild(background);
		
		var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>(Windows.NUMBER_OF_WINDOWS, true);
		
		var windowsController:Windows = new Windows(windows, binder);
		
		var navigation:Navigation = new Navigation(windowsController, binder);
		shellRoot.addChild(navigation);
		
		windows[Windows.GAME] = gameRoot;
		windows[Windows.ACHIEVEMENTS] = new AchievementsWindow(binder);
		windows[Windows.SETTINGS] = new SettingsWindow(binder);
		windows[Windows.CREDITS] = new CreditsWindow();
		
		for (var i:int = 1; i < Windows.NUMBER_OF_WINDOWS; ++i)
		{
			shellRoot.addChild(windows[i]);
			windows[i].visible = false;
		}
	}
	
}