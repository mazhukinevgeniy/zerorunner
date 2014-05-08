package view.shell.achievements 
{
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import view.shell.WindowBase;
	
	public class AchievementsWindow  extends WindowBase
	{	
		//public static const WIDTH:Number = Main.WIDTH - (Navigation.WIDTH + 20);
		//public static const HEIGHT:Number = Main.HEIGHT - 20;
		
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
		
		public function AchievementsWindow(assets:AssetManager, flow:IUpdateDispatcher) 
		{
			var achData:Dictionary = new Dictionary();
			
			new AchievementsUpdater(flow, achData);
			this.achievementsSave = new AchievementViewer(achData);
			
			super();
			
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			
			this.assets = assets;
			
			this.substrate = new Quad(Window.WIDTH, Window.HEIGHT, 0xFFFFFF);
			this.substrate.alpha = Number.MIN_VALUE;
			this.achievementsContainer = new Sprite();
			this.edgesContainer = new Sprite();
			this.achievementDescription = new MessageBubble();
			this.achievementDescription.visible = false;
			this.lastDisplayedDescription = AchievementsWindow.UNDETERMINED;
			
			//this.addChild(new HexagonalGrid(this.assets));
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
			//TODO вернуть или полностью удалить работу с рёбрами
			var edgesData:Vector.<Point> = new Vector.<Point>;//Vector.<Point>(this.achievementsSave.edges);
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
				
//<<<<<<< HEAD
				//texture = this.assets.getTexture(nameOfSkin);
				//this.achievements.push(new ViewAchievement(i, this.achData.position, texture, this));
//=======
				texture = this.assets.getTextureAtlas("sprites").getTexture(nameOfSkin);
				this.achievements.push(new ViewAchievement(this.achData.position, texture, this));
//>>>>>>> feature/achievments
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
			
			trace(this.x, this.y);
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
		
		public function displayDescription(id:int, target:ViewAchievement):void
		{
			if (this.lastDisplayedDescription != id)
			{
				this.achData = this.achievementsSave.getAchievement(id);
				
				this.achievementDescription.updateMessage(this.achData.description, target);
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