package game.world.broods.checkpoint 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.ICoordinated;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.ConfigKit;
	import game.world.ISearcher;
	
	internal class CheckpointLogic extends ItemLogicBase
	{
		private const STEPS_BETWEEN_CHECKPOINTS:int = 20;
		
		public function CheckpointLogic(foundations:GameFoundations, world:ISearcher) 
		{
			super(new CheckpointView(foundations), foundations, world);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return super.getSpawningCell();
			
			//TODO: checkpoint per sector, please
		}
		
		override protected function getConfig():ConfigKit
		{
			return new ConfigKit(10000000, 10000000, 10000000);
		}
	}

}