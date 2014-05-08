package model.items.checkpoint 
{
	import model.items._utils.CheckpointPuppetBase;
	import model.metric.ICoordinated;
	
	internal class Checkpoint extends CheckpointPuppetBase
	{
		
		public function Checkpoint(master:CheckpointMaster, cell:ICoordinated) 
		{
			super(master, cell);
		}
		
		override public function get type():int { return Game.ITEM_CHECKPOINT; }
	}

}