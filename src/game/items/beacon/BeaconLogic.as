package game.items.beacon 
{
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.base.ItemBase;
	
	internal class BeaconLogic extends ItemBase
	{
		
		public function BeaconLogic(cell:ICoordinated, elements:GameElements) 
		{
			super(elements, new ExistenceCore(this, elements, cell));
		}
		
		
		
	}

}