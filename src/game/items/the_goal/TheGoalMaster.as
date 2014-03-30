package game.items.the_goal 
{
	import game.GameElements;
	import game.items._utils.CheckpointMasterBase;
	import game.metric.ICoordinated;
	
	public class TheGoalMaster extends CheckpointMasterBase
	{
		
		public function TheGoalMaster(elements:GameElements) 
		{
			
			
			super(elements);
		}
		
		override protected function gameStarted():void 
		{
			//TODO: spawn goal
		}
		
		override protected function getReachedCheckpoint():ICoordinated 
		{
			//TODO: check if reached
			
			return CheckpointMasterBase.ILLEGAL_CELL;
		}
		
		override protected function activateCheckpoint(place:ICoordinated):void 
		{
			//TODO: end game
		}
	}

}