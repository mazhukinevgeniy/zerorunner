package model.items.checkpoint 
{
	import game.GameElements;
	import game.items._utils.CheckpointPuppetBase;
	import game.metric.ICoordinated;
	
	internal class Checkpoint extends CheckpointPuppetBase
	{
		
		public function Checkpoint(master:CheckpointMaster, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_CHECKPOINT; }
	}

}