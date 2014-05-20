package model.items.concrete 
{
	import model.items.ItemBase;
	import model.metric.ICoordinated;
	
	internal class TheGoal extends ItemBase
	{
		
		public function TheGoal(master:TheGoalMaster, cell:ICoordinated) 
		{
			super(master, cell);
		}
		
		override public function get type():int 
		{
			return Game.ITEM_THE_GOAL;
		}
	}

}