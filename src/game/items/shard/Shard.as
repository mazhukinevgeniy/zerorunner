package game.items.shard 
{
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	
	internal class Shard extends PuppetBase
	{
		
		public function Shard(master:MasterBase, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_SHARD; }
		
		override protected function get isPassive():Boolean { return true; }
	}

}