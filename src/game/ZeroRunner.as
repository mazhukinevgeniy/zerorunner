package game 
{
	import game.achievements.AchievementsFeature;
	import game.actors.ActorsFeature;
	import game.hazards.HazardFeature;
	import game.input.InputManager;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	import game.state.GameState;
	import game.statistics.StatisticsFeature;
	import game.statistics.StatisticsPiece;
	import game.time.Time;
	import game.ui.KeyboardControls;
	import game.ui.UIExtendsions;
	import game.world.SearcherFeature;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	import utils.informers.InformerManager;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class ZeroRunner extends UpdateManager
	{
		public static const flowName:String = "Game Flow";
		
		public static const addToTheHUD:String = "addToTheHUD";
		
		public static const addInformerTo:String = "addInformerTo";
		public static const getInformerFrom:String = "getInformerFrom";
		
		public static const prerestore:String = "prerestore";
		public static const restore:String = "restore";
		
		public static const gameOver:String = "gameOver";
		public static const quitGame:String = "quitGame";
		
		public static const redraw:String = "redraw";
		public static const tick:String = "tick";
		public static const aftertick:String = "aftertick";
		
		public static const setPause:String = "setPause";
		
		public static const setGameContainer:String = "setGameContainer";
		
		
		
		
		
		protected var displayRoot:Sprite;
		protected var informers:InformerManager;
		
		public function ZeroRunner(assets:AssetManager) 
		{			
			super(ZeroRunner.flowName);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(ZeroRunner.setGameContainer);
			this.addUpdateListener(ChaoticUI.newGame);
			this.addUpdateListener(ZeroRunner.addToTheHUD);
			this.addUpdateListener(ZeroRunner.quitGame);
			
			this.informers = new InformerManager();
			this.informers.addInformer(AssetManager, assets);
		}
		
		update function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			
			var image:Image = new Image(this.informers.getInformer(AssetManager).getTextureAtlas("gameAtlas").getTexture("fall"));
			image.scaleX = 2 * Main.WIDTH / image.width;
			image.scaleY = 2 * Main.HEIGHT / image.height;
			
			image.x = -50;
			image.y = -50;
			
			viewRoot.addChild(image);
			
			Metric.initialize(40, 40, 81, 81);
			
			new GameState(this);
			new Time(this.displayRoot, this);
			new InputManager(this);
			
			new SearcherFeature(this, this.informers.getInformer(AssetManager));
			new UIExtendsions(this);
			
			new SceneFeature(this);
			new ActorsFeature(this);
			new HazardFeature(this);
			
			new StatisticsFeature(this); //TODO: remove
			new AchievementsFeature(this);
			
			this.dispatchUpdate(KeyboardControls.addKeyboardEventListenersTo, Starling.current.stage);
			
			this.dispatchUpdate(ZeroRunner.addInformerTo, informers);
			this.dispatchUpdate(ZeroRunner.getInformerFrom, informers);
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