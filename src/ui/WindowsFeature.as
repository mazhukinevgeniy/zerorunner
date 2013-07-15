package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import flash.utils.Dictionary;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.mainMenu.MainMenu;
	import starling.display.DisplayObject;
	import ui.statistics.StatisticsWindow;
	import ui.achievements.AchievementsWindow;
	import ui.credits.CreditsWindow;
	/**
	 * ...
	 * @author 
	 */
	public class WindowsFeature
	{
		public static const PLAY:String = "Play";
		public static const STATISTICS:String = "Statistics";
		public static const ACHIEVEMENTS:String = "Achievements";
		public static const CREDITS:String = "Credits";
		public static const GAME:String = "Game";
		
		
		public static const X:Number = MainMenu.WIDTH_MAIN_MENU + WindowsFeature.INDENT;
		public static const Y:Number = WindowsFeature.INDENT;
		public static const WIDTH:Number = Main.WIDTH - WindowsFeature.INDENT - WindowsFeature.X;
		public static const HEIGHT:Number = Main.HEIGHT - 2 * WindowsFeature.INDENT;
		
		private static const INDENT:Number = 30;
		
		private var flow:IUpdateDispatcher;
		private var assets:AssetManager;
		
		public function WindowsFeature(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.flow = flow;
			this.assets = assets;
			
			var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			
			windows.push(new MainMenu(flow, assets));
			windows.push(new StatisticsWindow(flow));
			windows.push(new AchievementsWindow(flow));
			windows.push(new CreditsWindow(flow));
			
			new WindowsController(root, flow, windows);
			
		}
		
	}

}