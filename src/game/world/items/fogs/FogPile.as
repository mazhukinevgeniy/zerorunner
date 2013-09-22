package game.world.items.fogs 
{
	import game.core.GameFoundations;
	import game.core.metric.CellXY;
	import game.core.metric.Metric;
	import game.world.items.ItemLogicBase;
	
	internal class FogPile extends ItemLogicBase
	{
		
		public function FogPile(foundations:GameFoundations) 
		{
			super(new FogPileView(this, foundations), foundations);
			
			
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(0, 0);
		}
	}

}