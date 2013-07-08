package chaotic 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.core.Chaotic;
	import chaotic.grinder.GrinderFeature;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.scene.SceneFeature;
	import chaotic.xml.getAdditionalUpdatesXML;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class ZeroRunner extends Chaotic
	{
		
		public function ZeroRunner(container:Sprite, assets:AssetManager) 
		{
			super(container, assets);
		}
		
		override protected function getAdditionalUpdatesXMLList():XMLList
		{
			return getAdditionalUpdatesXML().update;
		}
		
		override protected function addFeatures():void
		{
			Metric.initialize(40, 40, 81, 81);
			
			this.addFeature(new DataExtensions());
			this.addFeature(new HUDExtendsions());
			
			this.addFeature(new SceneFeature());
			this.addFeature(new GrinderFeature());
			this.addFeature(new ActorsFeature());
		}
	}

}