package ui.windows.achievements 
{
	import feathers.controls.ScrollContainer;
	import progress.achievements.AchievementData;
	import progress.achievements.IAchievements;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import utils.updates.update;
	import starling.utils.AssetManager;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = Main.WIDTH;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = Main.HEIGHT;
		
		internal static const NUMBER_CELLS_IN_HEIGHT:int = 5;
		
		private var assets:AssetManager;
		
		private var numberOfAchievements:int
		
		private var achievementSave:IAchievements;
		private var achievements:Vector.<AchievementItem>;
		private var tableLocks:AchievementsTable;
		
		
		public function AchievementsWindow(assets:AssetManager, achievementSave:IAchievements) 
		{
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW + 150;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			
			this.assets = assets;
			
			this.addChild(new HexagonalGrid(this.assets));
			
			this.achievementSave = achievementSave;
			
			this.numberOfAchievements = this.achievementSave.numberOfAchievements;
			
			this.tableLocks = new AchievementsTable();
			this.createAchievementItems();
			this.drawAchievements();
		}
		
		private function createAchievementItems():void
		{
			var achievementData:AchievementData;
			var nameOfSkin:String
			var texture:Texture;
			
			this.achievements = new Vector.<AchievementItem>;
			
			for (var i:int = 0; i < this.numberOfAchievements; ++i)
			{
				achievementData = this.achievementSave.getAchievement(i);

				if (achievementData.unlocked)
					nameOfSkin = achievementData.enabledSkin;
				else
					nameOfSkin = achievementData.disabledSkin;
				
				texture = this.assets.getTextureAtlas("gameAtlas").getTexture(nameOfSkin);
				this.achievements.push(new AchievementItem(i, achievementData.position, texture));
			}
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