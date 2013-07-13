package game.scene 
{
	import game.actors.ActorsFeature;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IStoreInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.patterns.ScenePattern;
	import game.ZeroRunner;
	
	internal class Scene implements IScene
	{		
		private var patterns:Vector.<ScenePattern>;
		
		private var cacher:LandscapeCache;
		
		public function Scene(flow:IUpdateDispatcher) 
		{
			this.patterns = new Vector.<ScenePattern>(SceneFeature.NUMBER_OF_PATTERNS, true);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
		}
		
		public function getSceneCell(cell:CellXY):int
		{
			return (this.patterns[uint((cell.x * 84673) ^ (cell.y * 108301)) % SceneFeature.NUMBER_OF_PATTERNS].getNumber(cell.x, cell.y) % 4 == 0 ? SceneFeature.FALL : SceneFeature.ROAD);
		}
		
		public function prerestore():void
		{
			for (var i:int = 0; i < SceneFeature.NUMBER_OF_PATTERNS; i++)
			{
				this.patterns[i] = new ScenePattern();
			}
		}
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IScene, this);
		}
	}

}