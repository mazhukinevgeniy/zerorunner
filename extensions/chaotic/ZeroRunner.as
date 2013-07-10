package chaotic 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.game.ChaoticGame;
	import chaotic.grinder.GrinderFeature;
	import chaotic.input.InputManager;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.scene.SceneFeature;
	import chaotic.statistics.Statistics;
	import chaotic.ui.KeyboardControls;
	import chaotic.ui.UIExtendsions;
	import starling.core.Starling;
	import starling.utils.AssetManager;
	
	public class ZeroRunner extends ChaoticGame
	{
		public static const TIME_BETWEEN_TICKS:Number = 0.12;
		
		public function ZeroRunner(assets:AssetManager) 
		{
			super(assets);
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
	}

}