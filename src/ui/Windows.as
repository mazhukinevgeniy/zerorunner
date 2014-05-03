package ui 
{
	import game.GameElements;
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
		
		public function Windows(elements:GameElements) 
		{
			var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>(Windows.NUMBER_OF_WINDOWS, true);
			
			windows[Windows.GAME] = elements.displayRoot;
			windows[Windows.ACHIEVEMENTS] = new Sprite();//new AchievementsWindow(elements.assets, elements.flow);
			windows[Windows.SETTINGS] = new SettingsWindow(elements.flow, elements.preferences);
			windows[Windows.CREDITS] = new CreditsWindow(elements.flow);
			
			windows[0].visible = false;
			for (var i:int = 1; i < Windows.NUMBER_OF_WINDOWS; ++i)
			{
				this.addChild(windows[i]);
				windows[i].visible = false;
			}
			
			new WindowsController(elements.flow, windows);
		}
		
	}

}