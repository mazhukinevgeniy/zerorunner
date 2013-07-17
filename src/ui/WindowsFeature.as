package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.ScrollContainer;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.statistics.StatisticsWindow;
	import ui.achievements.AchievementsWindow;
	import ui.credits.CreditsWindow;
	import ui.mainMenu.MainMenu;
	
	public class WindowsFeature
	{
		public static const PLAY:String = "Play";
		
		public static const MENU:String = "Menu";
		public static const STATISTICS:String = "Statistics";
		public static const ACHIEVEMENTS:String = "Achievements";
		public static const CREDITS:String = "Credits";
		
		private var flow:IUpdateDispatcher;
		private var assets:AssetManager;
		
		public function WindowsFeature(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.flow = flow;
			this.assets = assets;
			
			var windows:Vector.<ScrollContainer> = new Vector.<ScrollContainer>();
			
			windows.push(new MainMenu(flow, assets, WindowsFeature.MENU));
			windows.push(new StatisticsWindow(flow, WindowsFeature.STATISTICS));
			windows.push(new AchievementsWindow(flow, WindowsFeature.ACHIEVEMENTS));
			windows.push(new CreditsWindow(flow, WindowsFeature.CREDITS));
			
			new WindowsController(root, flow, windows);
			
		}
		
	}

}