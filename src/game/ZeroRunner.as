package game 
{
	import game.achievements.AchievementsFeature;
	import game.input.InputManager;
	import game.items.ActorsFeature;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.SceneFeature;
	import game.statistics.StatisticsFeature;
	import game.statistics.StatisticsPiece;
	import game.time.Time;
	import game.ui.KeyboardControls;
	import game.ui.UIExtendsions;
	import game.utils.GameFoundations;
	import game.world.ISearcher;
	import game.world.SearcherFeature;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class ZeroRunner extends UpdateManager
	{
		public static const flowName:String = "Game Flow";
		
		public static const addToTheHUD:String = "addToTheHUD";
		
		public static const prerestore:String = "prerestore";
		public static const restore:String = "restore";
		
		public static const gameOver:String = "gameOver";
		public static const quitGame:String = "quitGame";
		
		public static const redraw:String = "redraw";
		public static const tick:String = "tick";
		public static const aftertick:String = "aftertick";
		
		public static const setPause:String = "setPause";
		
		public static const setGameContainer:String = "setGameContainer";
		
		
		
		
		
		private var displayRoot:Sprite;
		
		private var atlas:TextureAtlas;
		
		public function ZeroRunner(assets:AssetManager) 
		{			
			super(ZeroRunner.flowName);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(ZeroRunner.setGameContainer);
			this.addUpdateListener(ChaoticUI.newGame);
			this.addUpdateListener(ZeroRunner.addToTheHUD);
			this.addUpdateListener(ZeroRunner.quitGame);
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
		}
		
		update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			this.displayRoot.stage.color = 0;
			
			var foundations:GameFoundations = new GameFoundations
					(this, new Juggler(), this.atlas, new InputManager(this));
			
			new Time(this.displayRoot, foundations);
			new InputManager(this);
			
			var world:ISearcher = new SearcherFeature(foundations);
			new UIExtendsions(this);
			
			new SceneFeature(this);
			new ActorsFeature(foundations, world);
			
			new StatisticsFeature(this);
			new AchievementsFeature(this);
			
			this.dispatchUpdate(KeyboardControls.addKeyboardEventListenersTo, Starling.current.stage);
		}
		
		
		update function newGame():void
		{
			this.dispatchUpdate(ZeroRunner.prerestore);
			this.dispatchUpdate(ZeroRunner.restore);
		}
		
		update function quitGame():void
		{
			this.dispatchUpdate(UpdateManager.callExternalFlow, ChaoticUI.flowName, ZeroRunner.quitGame);
		}
		
		final update function addToTheHUD(item:DisplayObject):void
		{
			this.displayRoot.addChild(item);
		}
	}

}