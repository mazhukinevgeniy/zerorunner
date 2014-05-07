package view.shell 
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import view.shell.achievements.AchievementsWindow;
	import view.shell.credits.CreditsWindow;
	import view.shell.settings.SettingsWindow;
	
	public function initializeShell(shellRoot:DisplayObjectContainer, 
	                                gameRoot:DisplayObjectContainer):void
	{
		var background:Background = new Background();
		
		shellRoot.addChild(background);
		
		var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>(Windows.NUMBER_OF_WINDOWS, true);
		
		windows[WindowsController.GAME] = gameRoot;
		windows[WindowsController.ACHIEVEMENTS] = new new AchievementsWindow();
		windows[WindowsController.SETTINGS] = new SettingsWindow();
		windows[WindowsController.CREDITS] = new CreditsWindow();
		
		for (var i:int = 1; i < WindowsController.NUMBER_OF_WINDOWS; ++i)
		{
			shellRoot.addChild(windows[i]);
			windows[i].visible = false;
		}
		
		var windowsController:WindowsController = new WindowsController(windows);
		
		var navigation:Navigation = new Navigation(windowsController);
		
		shellRoot.addChild(navigation);
		
	}
	
}