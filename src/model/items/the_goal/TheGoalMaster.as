package model.items.the_goal 
{
	import binding.IBinder;
	import model.interfaces.IStatus;
	import model.items._utils.CheckpointMasterBase;
	import model.items.Items;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	
	public class TheGoalMaster extends CheckpointMasterBase
	{
		private var currentGoal:TheGoal;
		
		private var status:IStatus;
		
		public function TheGoalMaster(binder:IBinder, items:Items) 
		{
			super(binder, items);
			
			this.status = binder.gameStatus;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			var cell:CellXY = new CellXY(x, y);
			
			this.currentGoal = new TheGoal(this, cell);
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