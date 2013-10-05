package ui.windows.achievements 
{
	import feathers.controls.ScrollContainer;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import starling.utils.AssetManager;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		
		private var flow:IUpdateDispatcher;
		private var achievements:Vector.<AchievementItem>;
		private var tableLocks:AchievementsTable;
		
		
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = Main.WIDTH;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = Main.HEIGHT;
		
		internal static const NUMBER_CELLS_IN_HEIGHT:int = 5;
		
		public function AchievementsWindow(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			root.addChild(this);
			this.visible = false;
			
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW + 150;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			
			this.addChild(new HexagonalGrid(assets));
			
			this.tableLocks = new AchievementsTable();
			this.achievements = new Vector.<AchievementItem>;
			
			(this.achievements).push(new AchievementItem(this.tableLocks));
			this.drawAchievements();

			
			this.flow = flow;
		}
		
		private function drawAchievements():void
		{
			var lenght:int = (this.achievements).length;
			
			for (var i:int = 0; i < lenght; ++i)
			{
				this.addChild(this.achievements[i]);
			}
		}
	}

}