package game.items.beacon 
{
	import game.GameElements;
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	
	internal class Beacon extends PuppetBase
	{
		
		public function Beacon(master:BeaconMaster, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_BEACON; }
		
		override protected function get isPassive():Boolean { return true; }
	}

}