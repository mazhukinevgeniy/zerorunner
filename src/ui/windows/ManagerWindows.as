package ui.windows 
{
	import chaotic.core.IUpdateDispatcher;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
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
		
		
		private var flow:IUpdateDispatcher;
		private var assets:AssetManager;
		
		public function ManagerWindows(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.flow = flow;
			this.assets = assets;
			
			new StatisticsWindow(root, flow);
			
		}
		
	}

}