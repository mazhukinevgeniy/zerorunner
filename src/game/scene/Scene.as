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
			return (this.patterns[Metric.getHash(cell) % SceneFeature.NUMBER_OF_PATTERNS].getNumber(cell.x, cell.y) % 4 == 0 ? SceneFeature.FALL : SceneFeature.ROAD);
		}
		
		public function prerestore():void
		{
			do
			{
				for (var i:int = 0; i < SceneFeature.NUMBER_OF_PATTERNS; i++)
				{
					this.patterns[i] = new ScenePattern();
				}
			}
			while (this.probablyCanNotLeave(ActorsFeature.SPAWN_CELL));
		}
		
		private function probablyCanNotLeave(cell:CellXY):Boolean
		{
			if (this.getSceneCell(cell) == SceneFeature.FALL)
				return true;
			
			var rightWay:int = 0;
			
			var right:DCellXY = new DCellXY(1, 0);
			var up:DCellXY = new DCellXY(0, -1);
			
			while (rightWay < 10)
			{
				if (this.getSceneCell(new CellXY(cell.x + 1, cell.y)) == SceneFeature.ROAD)
				{
					cell.applyChanges(right);
					rightWay++;
				}
				else if (this.getSceneCell(new CellXY(cell.x, cell.y - 1)) == SceneFeature.ROAD)
				{
					cell.applyChanges(up);
				}
				else return true;
			}
			return false;
		}
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IScene, this);
		}
	}

}