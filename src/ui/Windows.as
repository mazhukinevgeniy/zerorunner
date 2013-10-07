package ui 
{
	import progress.ProgressManager;
	import progress.statistics.IStatistic;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.windows.achievements.AchievementsWindow;
	import ui.windows.credits.CreditsWindow;
	import ui.windows.statistics.StatisticsWindow;
	import utils.updates.IUpdateDispatcher;
	
	public class Windows extends Sprite
	{
		public static const PLAY:String = "Play";
		
		public static const GAME:int = 0;
		public static const STATISTICS:int = 1;
		public static const ACHIEVEMENTS:int = 2;
		public static const CREDITS:int = 3;
		
		private static const NUMBER_OF_WINDOWS:int = 4;
		
		public function Windows(flow:IUpdateDispatcher, assets:AssetManager, progressManager:ProgressManager) 
		{
			var windows:Vector.<DisplayObject> = new Vector.<DisplayObject>(Windows.NUMBER_OF_WINDOWS, true);
			
			windows[Windows.GAME] = new Sprite();
			windows[Windows.STATISTICS] = new StatisticsWindow(flow, progressManager.statistics);
			windows[Windows.ACHIEVEMENTS] = new AchievementsWindow(flow, assets);
			windows[Windows.CREDITS] = new CreditsWindow(flow);
			
			for (var i:int = 0; i < Windows.NUMBER_OF_WINDOWS; ++i)
			{
				this.addChild(windows[i]);
				windows[i].visible = false;
			}
			
			flow.dispatchUpdate(Update.setGameContainer, windows[Windows.GAME]);
			
			
			new WindowsController(flow, windows);
		}
		
	}

}