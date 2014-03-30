package game.items.the_goal 
{
	import game.GameElements;
	import game.items._utils.CheckpointMasterBase;
	import game.metric.ICoordinated;
	
	public class TheGoalMaster extends CheckpointMasterBase
	{
		private var currentGoal:TheGoal;
		
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
			this.elements.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_WON);
			
			this.currentGoal = null;
		}
	}

}