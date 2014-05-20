package model.items.shard 
{
	import model.items.ItemBase;
	import model.metric.ICoordinated;
	
	internal class Shard extends ItemBase
	{
		
		public function Shard(master:ShardMaster, cell:ICoordinated) 
		{
			super(master, cell);
		}
		
		override public function get type():int { return Game.ITEM_SHARD; }
	}

}