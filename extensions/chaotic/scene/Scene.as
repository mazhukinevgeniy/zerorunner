package chaotic.scene 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.informers.IStoreInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.scene.patterns.ScenePattern;
	import chaotic.updates.IInformerAdder;
	import chaotic.updates.IPrerestorable;
	
	internal class Scene implements IPrerestorable, IScene, IInformerAdder
	{		
		private var patterns:Vector.<ScenePattern>;
		
		public function Scene() 
		{
			this.patterns = new Vector.<ScenePattern>(SceneFeature.NUMBER_OF_PATTERNS, true);
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