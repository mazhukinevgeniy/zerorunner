package game 
{
	import game.actors.ActorsFeature;
	import chaotic.game.ChaoticGame;
	import game.grinder.GrinderFeature;
	import game.input.InputManager;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	import game.statistics.Statistics;
	import game.ui.KeyboardControls;
	import game.ui.UIExtendsions;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.utils.AssetManager;
	
	public class ZeroRunner extends ChaoticGame
	{
		public static const TIME_BETWEEN_TICKS:Number = 0.12;
		
		private var juggler:Juggler;
		
		public function ZeroRunner(assets:AssetManager) 
		{			
			super(assets);
			
			this.workWithUpdateListener(this);
		}
		
		override protected function addFeatures():void
		{
			super.addFeatures();
			
			Metric.initialize(40, 40, 81, 81);
			
			new InputManager(this);
			new Statistics(this);
			new UIExtendsions(this);
			
			new GrinderFeature(this);
			new ActorsFeature(this);
			new SceneFeature(this);
			
			this.dispatchUpdate(KeyboardControls.addKeyboardEventListenersTo, Starling.current.stage);
		}
		
		override public function newGame():void
		{
			super.newGame();
			
			this.juggler = this.informers.getInformer(Juggler);
			
			this.juggler.delayCall(this.prepareTick, ZeroRunner.TIME_BETWEEN_TICKS);
		}
		
		private function prepareTick():void
		{
			this.dispatchUpdate(ChaoticGame.tick);
			
			this.juggler.delayCall(this.prepareTick, ZeroRunner.TIME_BETWEEN_TICKS);
		}
	}

}