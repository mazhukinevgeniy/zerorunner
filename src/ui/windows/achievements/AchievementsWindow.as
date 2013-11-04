package ui.windows.achievements 
{
	import data.viewers.AchievementViewer;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import starling.utils.AssetManager;
	
	public class AchievementsWindow  extends ScrollContainer
	{	
		public static const WIDTH_ACHIEVMENTS_WINDOW:Number = Main.WIDTH;
		public static const HEIGHT_ACHIEVMENTS_WINDOW:Number = Main.HEIGHT;
		
		private static const UNDETERMINED:int = -1;
		
		private var assets:AssetManager;
		
		private var numberOfAchievements:int
		
		private var achievementsSave:AchievementViewer;
		private var edgesContainer:Sprite;
		private var achievementsContainer:Sprite;
		private var substrate:Quad;
		private var edges:Vector.<Edge>;
		private var achievements:Vector.<ViewAchievement>;
		
		private var achievementDescription:MessageBubble;
		private var lastDisplayedDescription:int;
		
		private var achData:Achievement;
		
		private var flow:IUpdateDispatcher;
		
		public function AchievementsWindow(assets:AssetManager, achievementsSave:AchievementViewer, flow:IUpdateDispatcher) 
		{
			//this.achData = this.achievementsSave
			
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
			this.edgesContainer = new Sprite();
			this.achievementDescription = new MessageBubble();
			this.achievementDescription.visible = false;
			this.lastDisplayedDescription = AchievementsWindow.UNDETERMINED;
			
			this.addChild(new HexagonalGrid(this.assets));
			this.addChild(this.edgesContainer);
			this.addChild(this.substrate);
			this.addChild(this.achievementsContainer);
			this.addChild(this.achievementDescription);
			
			this.achievementsSave = achievementsSave;
			this.flow = flow;
			
			this.substrate.addEventListener(TouchEvent.TOUCH, this.handleSubstrateTouch)
		}
		
		private function createEdges():void
		{
			var edgesData:Vector.<Point> = this.achievementsSave.edges;
			var lenght:int;
			
			lenght = edgesData.length;
			this.edges = new Vector.<Edge>;
			
			for (var i:int = 0; i < lenght; ++i)
			{
				this.edges.push(new Edge(edgesData[i]));
			}
		}
		
		private function createViewAchievement():void
		{
			var nameOfSkin:String
			var texture:Texture;
			
			this.achievements = new Vector.<ViewAchievement>;
			this.numberOfAchievements = this.achievementsSave.numberOfAchievements;
			
			for (var i:int = 0; i < this.numberOfAchievements; ++i)
			{
				this.achData = this.achievementsSave.getAchievement(i, false);

				if (this.achData.unlocked)
					nameOfSkin = this.achData.enabledSkin;
				else
					nameOfSkin = this.achData.disabledSkin;
				
				texture = this.assets.getTextureAtlas("gameAtlas").getTexture(nameOfSkin);
				this.achievements.push(new ViewAchievement(this.achData.position, texture, this));
			}
		}
		
		public override function set visible(newValue:Boolean):void
		{
			if (newValue)
			{
				//this.updateData();
				//this.redrawAchievements();
				this.createEdges();
				this.createViewAchievement();
				this.redrawGraph();
			}
			
			super.visible = newValue;
		}
		
		private function redrawGraph():void
		{
			var i:int;
			var lenght:int = (this.achievements).length;
			
			this.achievementsContainer.removeChildren();
			this.edgesContainer.removeChildren();
			
			for (i = 0; i < lenght; ++i)
			{
				this.achievementsContainer.addChild(this.achievements[i]);
			}
			
			lenght = this.edges.length;
			
			for (i = 0; i < lenght; ++i)
			{
				this.edgesContainer.addChild(this.edges[i]);
			}
		}
		
		public function displayDescription(id:int):void
		{
			if (this.lastDisplayedDescription != id)
			{
				this.achData = this.achievementsSave.getAchievement(id);
				
				this.achievementDescription.updateMessage(this.achData.description, this.achievements[id]);
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
				this.lastDisplayedDescription = AchievementsWindow.UNDETERMINED;
			}	
		}
	}

}