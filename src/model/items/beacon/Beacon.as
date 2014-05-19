package model.items.beacon 
{
	import model.items.PuppetBase;
	import model.metric.ICoordinated;
	
	internal class Beacon extends PuppetBase
	{
		
		public function Beacon(master:BeaconMaster, cell:ICoordinated) 
		{
			super(master, cell);
		}
		
		override public function get type():int { return Game.ITEM_BEACON; }
	}

}