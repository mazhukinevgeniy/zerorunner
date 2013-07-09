package chaotic 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.choosenArea.ChoosenArea;
	import chaotic.game.ChaoticGame;
	import chaotic.grinder.GrinderFeature;
	import chaotic.input.InputManager;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.scene.SceneFeature;
	import chaotic.statistics.Statistics;
	import chaotic.ui.UIExtendsions;
	import chaotic.xml.getAdditionalUpdatesXML;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class ZeroRunner extends ChaoticGame
	{
		
		public function ZeroRunner(container:Sprite, assets:AssetManager) 
		{
			super(container, assets);
			
			this.updateFlow.dispatchUpdate("addKeyboardEventListenersTo", Starling.current.stage);
		}
		
		override protected function addFeatures():void
		{
			super.addFeatures();
			
			Metric.initialize(40, 40, 81, 81);
			
			new InputManager(this.updateFlow);
			new Statistics(this.updateFlow);
			new ChoosenArea(this.updateFlow);
			new UIExtendsions(this.updateFlow);
			
			new SceneFeature(this.updateFlow);
			new GrinderFeature(this.updateFlow);
			new ActorsFeature(this.updateFlow);
		}
	}

}