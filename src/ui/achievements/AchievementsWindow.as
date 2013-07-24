package ui.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import feathers.controls.ScrollContainer;
	import game.achievements.AchievementBase;
	import starling.display.Quad;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		public static const initializeTree:String = "initializeTree";
		public static const unlockNode:String = "unlockNode";
		
		
		private var flow:IUpdateDispatcher;
		
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = 350;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = 400;
		
		public function AchievementsWindow(flow:IUpdateDispatcher, name:String = "AchievementsWindow") 
		{
			this.name = name; //TODO: what are you doing? i guess, extra parameter is not required
			
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.visible = false;
			
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