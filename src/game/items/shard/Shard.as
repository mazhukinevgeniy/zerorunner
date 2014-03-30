package game.items.shard 
{
	import game.GameElements;
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	
	internal class Shard extends PuppetBase
	{
		
		public function Shard(master:ShardMaster, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_SHARD; }
		
		override protected function get isPassive():Boolean { return true; }
	}

}