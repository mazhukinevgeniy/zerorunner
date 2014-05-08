package view.shell 
{
	import binding.IBinder;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import view.shell.credits.CreditsWindow;
	import view.shell.settings.SettingsWindow;
	
	public function initializeShell(shellRoot:DisplayObjectContainer, 
	                                gameRoot:DisplayObjectContainer,
									binder:IBinder):void
	{
		var background:Background = new Background();
		
		shellRoot.addChild(background);
		
		var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>(Windows.NUMBER_OF_WINDOWS, true);
		
		windows[Windows.GAME] = gameRoot;
		windows[Windows.ACHIEVEMENTS] = new Sprite();//new AchievementsWindow();//TODO: do
		windows[Windows.SETTINGS] = new SettingsWindow();
		windows[Windows.CREDITS] = new CreditsWindow();
		
		for (var i:int = 1; i < Windows.NUMBER_OF_WINDOWS; ++i)
		{
			shellRoot.addChild(windows[i]);
			windows[i].visible = false;
		}
		
		var windowsController:Windows = new Windows(windows, binder);
		
		var navigation:Navigation = new Navigation(windowsController, binder);
		
		shellRoot.addChild(navigation);
		
	}
	
}