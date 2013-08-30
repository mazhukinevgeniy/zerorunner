package game.world.broods.checkpoint 
{
	import game.core.GameFoundations;
	import game.core.metric.CellXY;
	import game.world.broods.ItemLogicBase;
	
	public class CheckpointLogic extends ItemLogicBase
	{
		
		public function CheckpointLogic(foundations:GameFoundations) 
		{
			super(new CheckpointView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return super.getSpawningCell();
			
			//TODO: checkpoint per sector, please
		}
	}

}