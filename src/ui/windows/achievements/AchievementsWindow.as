package ui.windows.achievements 
{
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import progress.achievements.AchievementData;
	import progress.achievements.IAchievements;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import utils.updates.update;
	import starling.utils.AssetManager;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = Main.WIDTH;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = Main.HEIGHT;
		
		private static const UNDETERMINED:int = -1;
		
		private var assets:AssetManager;
		
		private var numberOfAchievements:int
		
		private var achievementSave:IAchievements;
		private var achievementsContainer:Sprite;
		private var substrate:Quad;
		private var achievements:Vector.<ViewAchievement>;
		
		private var achievementDescription:Label;
		private var lastDisplayedDescription:int;
		
		
		public function AchievementsWindow(assets:AssetManager, achievementSave:IAchievements) 
		{
			this.width = AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW;
			this.height = AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW;
			
			var tmp:Quad = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.backgroundSkin = tmp;
			
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			
			this.assets = assets;
			
			this.substrate = new Quad(AchievementsWindow.WIDTH_ACHIEVMENTS_WINDOW, AchievementsWindow.HEIGHT_ACHIEVMENTS_WINDOW, 0xFFFFFF);
			this.substrate.alpha = Number.MIN_VALUE;
			this.achievementsContainer = new Sprite();
			this.achievementDescription = new Label();
			this.achievementDescription.visible = false;
			this.lastDisplayedDescription = AchievementsWindow.UNDETERMINED;
			
			this.addChild(new HexagonalGrid(this.assets));
			this.achievementsContainer.addChild(this.substrate);
			this.addChild(this.achievementsContainer);
			this.addChild(this.achievementDescription);
			
			this.achievementSave = achievementSave;
			
			this.numberOfAchievements = this.achievementSave.numberOfAchievements;
			
			this.createAchievementItems();
			this.redrawAchievements();
			
			this.substrate.addEventListener(TouchEvent.TOUCH, this.handleSubstrateTouch)
		}
		
		private function createAchievementItems():void
		{
			var achievementData:AchievementData;
			var nameOfSkin:String
			var texture:Texture;
			
			this.achievements = new Vector.<ViewAchievement>;
			
			for (var i:int = 0; i < this.numberOfAchievements; ++i)
			{
				achievementData = this.achievementSave.getAchievement(i);

				if (achievementData.unlocked)
					nameOfSkin = achievementData.enabledSkin;
				else
					nameOfSkin = achievementData.disabledSkin;
				
				texture = this.assets.getTextureAtlas("gameAtlas").getTexture(nameOfSkin);
				this.achievements.push(new ViewAchievement(i, achievementData.position, texture, this));
			}
		}
		
		public override function set visible(newValue:Boolean):void
		{
			if (newValue)
			{
				this.updateData();
				//this.redrawAchievements();
			}
			
			super.visible = newValue;
		}
		
		private function updateData():void
		{
			
		}
		
		private function redrawAchievements():void
		{
			var lenght:int = (this.achievements).length;
			
			for (var i:int = 0; i < lenght; ++i)
			{
				this.achievementsContainer.addChild(this.achievements[i]);
			}
		}
		
		public function displayDescription(id:int, mouseX:Number, mouseY:Number):void
		{
			if (this.lastDisplayedDescription != id)
			{
				var achievementData:AchievementData = this.achievementSave.getAchievement(id);
			
				this.achievementDescription.text = achievementData.description;
				if (mouseX + this.achievementDescription.width > Main.WIDTH)
					this.achievementDescription.x = mouseX - this.achievementDescription.width;
				else
					this.achievementDescription.x = mouseX;
					
				if (mouseY - this.achievementDescription.height > 0)
					this.achievementDescription.y = mouseY + 10;
				else
					this.achievementDescription.y = mouseY - 10;
					
				this.achievementDescription.visible = true;
				
				this.lastDisplayedDescription = id;
			}
			
		}
		
		private function handleSubstrateTouch(event:TouchEvent):void
		{
			var touchHover:Touch = event.getTouch(this.substrate, TouchPhase.HOVER)
			
			if (touchHover)
			{
				this.achievementDescription.visible = false;
			}	
		}
	}

}