package ui 
{
	import data.DatabaseManager;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.themes.Theme;
	import ui.windows.achievements.AchievementsWindow;
	import ui.windows.credits.CreditsWindow;
	import ui.windows.settings.SettingsWindow;
	import utils.updates.IUpdateDispatcher;
	
	public class Windows extends Sprite
	{
		public static const PLAY:String = "Play";
		
		public static const GAME:int = 0;
		public static const ACHIEVEMENTS:int = 1;
		public static const SETTINGS:int = 2;
		public static const CREDITS:int = 3;
		
		private static const NUMBER_OF_WINDOWS:int = 4;
		
		public function Windows(flow:IUpdateDispatcher, assets:AssetManager, database:DatabaseManager, gameRoot:DisplayObjectContainer) 
		{
			var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>(Windows.NUMBER_OF_WINDOWS, true);
			
			windows[Windows.GAME] = gameRoot;
			windows[Windows.ACHIEVEMENTS] = new AchievementsWindow(assets, database.achievements, flow);
			windows[Windows.SETTINGS] = new SettingsWindow(database.preferences);
			windows[Windows.CREDITS] = new CreditsWindow(flow);
			
			
			for (var i:int = 0; i < Windows.NUMBER_OF_WINDOWS; ++i)
			{
				this.addChild(windows[i]);
				windows[i].visible = false;
			}
			
			new WindowsController(flow, windows);
		}
		
	}

}