package game.items.beacon 
{
	import game.core.metric.CellXY;
	import game.GameElements;
	import game.items.ActivityCore;
	import game.items.ItemBase;
	import game.items.OccupationCore;
	
	internal class BeaconLogic extends ItemBase
	{
		
		public function BeaconLogic(cell:CellXY, elements:GameElements) 
		{
			super(elements, new ActivityCore(), new OccupationCore(), null);
			//TODO: use custom occupation core
		}
		
		
		
	}

}