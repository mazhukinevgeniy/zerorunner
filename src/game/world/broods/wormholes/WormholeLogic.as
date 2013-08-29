package game.world.broods.wormholes 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.Metric;
	import game.world.broods.ItemLogicBase;
	
	public class WormholeLogic extends ItemLogicBase
	{
		
		public function WormholeLogic(foundations:GameFoundations) 
		{
			super(new WormholeView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.SECTOR_WIDTH * (1 + (this.game).mapWidth) - 1, Game.SECTOR_WIDTH);
		}
	}

}