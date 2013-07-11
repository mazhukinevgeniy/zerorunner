package game 
{
	import chaotic.core.UpdateManager;
	import chaotic.informers.InformerManager;
	import game.actors.ActorsFeature;
	import game.grinder.GrinderFeature;
	import game.input.InputManager;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	import game.statistics.Statistics;
	import game.time.Time;
	import game.ui.KeyboardControls;
	import game.ui.UIExtendsions;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	public class ZeroRunner extends UpdateManager
	{
		public static const flowName:String = "Game Flow";
		
		public static const addToTheHUD:String = "addToTheHUD";
		
		public static const addInformerTo:String = "addInformerTo";
		public static const getInformerFrom:String = "getInformerFrom";
		
		public static const prerestore:String = "prerestore";
		public static const restore:String = "restore";
		
		public static const gameOver:String = "gameOver";
		
		public static const tick:String = "tick";
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
			
			this.informers = new InformerManager();
			this.informers.addInformer(AssetManager, assets);
		}
		
		public function setGameContainer(viewRoot:Sprite):void
		{
			this.displayRoot = viewRoot;
			viewRoot.addChild(new Quad(Main.WIDTH, Main.HEIGHT, 0xFF000000));//TODO: it causes extra redraws, must reimplement
			
			Metric.initialize(40, 40, 81, 81);
			
			new Time(this.displayRoot, this);
			new InputManager(this);
			new Statistics(this);
			new UIExtendsions(this);
			
			new GrinderFeature(this);
			new ActorsFeature(this);
			new SceneFeature(this);
			
			this.dispatchUpdate(KeyboardControls.addKeyboardEventListenersTo, Starling.current.stage);
			
			this.dispatchUpdate(ZeroRunner.addInformerTo, informers);
			this.dispatchUpdate(ZeroRunner.getInformerFrom, informers);
		}
		
		
		public function newGame():void
		{
			this.dispatchUpdate(ZeroRunner.prerestore);
			this.dispatchUpdate(ZeroRunner.restore);
		}
		
		final public function addToTheHUD(item:DisplayObject):void
		{
			this.displayRoot.addChild(item);
		}
	}

}