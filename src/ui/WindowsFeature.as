package ui 
{
	import feathers.controls.ScrollContainer;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.achievements.AchievementsWindow;
	import ui.credits.CreditsWindow;
	import ui.mainMenu.MainMenu;
	import utils.updates.IUpdateDispatcher;
	
	public class WindowsFeature
	{
		public static const PLAY:String = "Play";
		
		public static const MENU:int = 0;
		public static const STATISTICS:int = 1;
		public static const ACHIEVEMENTS:int = 2;
		public static const CREDITS:int = 3;
		
		private static const NUMBER_OF_WINDOWS:int = 4;
		
		public function WindowsFeature(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			var windows:Vector.<ScrollContainer> = new Vector.<ScrollContainer>(WindowsFeature.NUMBER_OF_WINDOWS, true);
			
			windows[WindowsFeature.MENU] = new MainMenu(flow);
			windows[WindowsFeature.STATISTICS] = new ScrollContainer();//new StatisticsWindow(flow); //TODO: make it working
			windows[WindowsFeature.ACHIEVEMENTS] = new AchievementsWindow(flow, assets);
			windows[WindowsFeature.CREDITS] = new CreditsWindow(flow);
			
			new WindowsController(root, flow, windows);
		}
		
	}

}