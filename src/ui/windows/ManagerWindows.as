package ui.windows 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.mainMenu.MainMenu;
	/**
	 * ...
	 * @author 
	 */
	public class ManagerWindows 
	{
		public static const PLAY:String = "Play";
		public static const STATISTICS:String = "Statistics";
		public static const ACHIEVEMENTS:String = "Achievements";
		public static const CREDITS:String = "Credits";
		public static const GAME:String = "Game";
		
		
		public static const X:Number = MainMenu.WIDTH_MAIN_MENU + ManagerWindows.INDENT;
		public static const Y:Number = ManagerWindows.INDENT;
		public static const WIDTH:Number = Main.WIDTH - ManagerWindows.INDENT - ManagerWindows.X;
		public static const HEIGHT:Number = Main.HEIGHT - 2 * ManagerWindows.INDENT;
		
		private static const INDENT:Number = 30;
		
		private var flow:IUpdateDispatcher;
		private var assets:AssetManager;
		
		public function ManagerWindows(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.flow = flow;
			this.assets = assets;
			
			new StatisticsWindow(root, flow);
			new AchievementsWindow(root, flow);
			new CreditsWindow(root, flow);
			
		}
		
	}

}