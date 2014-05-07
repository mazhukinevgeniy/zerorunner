package model.items.the_goal 
{
	import data.IStatus;
	import game.GameElements;
	import game.items._utils.CheckpointMasterBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public class TheGoalMaster extends CheckpointMasterBase
	{
		private var currentGoal:TheGoal;
		
		private var status:IStatus;
		
		public function TheGoalMaster(elements:GameElements) 
		{
			super(elements);
			
			this.status = elements.status;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			var cell:CellXY = new CellXY(x, y);
			
			this.currentGoal = new TheGoal(this, this.elements, cell);
		}
		
		override protected function getReachedCheckpoint():ICoordinated 
		{
			var center:ICoordinated = this.status.getLocationOfHero();
			
			if (Game.distance(center, this.currentGoal) < 2)
				return this.currentGoal;
			else
				return CheckpointMasterBase.ILLEGAL_CELL;
		}
		
		override protected function activateCheckpoint(place:ICoordinated):void 
		{
			this.elements.flow.dispatchUpdate(Update.gameFinished, Game.ENDING_WON);
			
			this.currentGoal = null;
		}
	}

}