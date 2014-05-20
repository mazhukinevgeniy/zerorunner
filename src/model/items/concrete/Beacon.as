package model.items.concrete 
{
	import model.items.ItemBase;
	import model.metric.ICoordinated;
	
	internal class Beacon extends ItemBase
	{
		
		public function Beacon(master:BeaconMaster, cell:ICoordinated) 
		{
			super(master, cell);
		}
		
		override public function get type():int { return Game.ITEM_BEACON; }
	}

}