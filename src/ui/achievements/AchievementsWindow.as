package ui.achievements 
{
	import feathers.controls.ScrollContainer;
	import game.core.achievements.AchievementBase;
	import starling.display.Quad;
	import ui.mainMenu.CompactMenu;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import starling.utils.AssetManager;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		public static const initializeTree:String = "initializeTree";
		public static const unlockNode:String = "unlockNode";
		
		
		private var flow:IUpdateDispatcher;
		private var achievements:Vector.<AchievementItem>;
		private var tableLocks:AchievementsTable;
		
		
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = Main.WIDTH;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = Main.HEIGHT;
		
		internal static const NUMBER_CELLS_IN_HEIGHT:int = 5;
		
		public function AchievementsWindow(flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW + 150;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			
			this.addChild(new HexagonalGrid(assets));
			this.addChild(new CompactMenu(flow));
			
			this.tableLocks = new AchievementsTable();
			this.achievements = new Vector.<AchievementItem>;
			this.update::initializeTree(new AchievementItem(this.tableLocks));
			
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(AchievementsWindow.initializeTree);
			flow.addUpdateListener(AchievementsWindow.unlockNode);
		}
		
		update  function initializeTree(node:AchievementItem):void
		{
			this.achievements.push(node);
			this.drawAchievements();
		}
		
		private function drawAchievements():void
		{
			var lenght:int = this.achievements.length;
			
			for (var i:int = 0; i < lenght; ++i)
			{
				this.addChild(this.achievements[i]);
			}
		}
		
		update function unlockNode(nodeID:int):void
		{
			
		}
	}

}