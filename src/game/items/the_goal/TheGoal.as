package game.items.the_goal 
{
	import game.GameElements;
	import game.items._utils.CheckpointPuppetBase;
	import game.metric.ICoordinated;
	
	internal class TheGoal extends CheckpointPuppetBase
	{
		
		public function TheGoal(master:TheGoalMaster, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
	}

}