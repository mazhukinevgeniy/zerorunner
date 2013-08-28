package game.world.broods.checkpoint 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.ICoordinated;
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