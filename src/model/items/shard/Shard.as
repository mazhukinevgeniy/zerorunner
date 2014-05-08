package model.items.shard 
{
	import model.items.PuppetBase;
	import model.metric.ICoordinated;
	
	internal class Shard extends PuppetBase
	{
		
		public function Shard(master:ShardMaster, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_SHARD; }
		
		override protected function get isPassive():Boolean { return true; }
	}

}