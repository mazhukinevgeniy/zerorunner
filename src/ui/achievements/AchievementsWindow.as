package ui.achievements 
{
	import feathers.controls.ScrollContainer;
	import game.achievements.AchievementBase;
	import starling.display.Quad;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		public static const initializeTree:String = "initializeTree";
		public static const unlockNode:String = "unlockNode";
		
		
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = 350;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = 400;
		
		public function AchievementsWindow(flow:IUpdateDispatcher) 
		{
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(AchievementsWindow.initializeTree);
			flow.addUpdateListener(AchievementsWindow.unlockNode);
		}
		
		update function initializeTree(node:AchievementBase):void
		{
			//TODO: you reset containers and start drawing and, damn it, just do something
		}
		
		update function unlockNode(nodeID:int):void
		{
			//TODO: achievement unlocked, you tell about it
		}
	}

}