package game.items.beacon 
{
	import game.core.metric.*;
	import game.GameElements;
	import game.items.base.cores.ExistenceCore;
	import game.items.base.ItemBase;
	import utils.updates.IUpdateDispatcher;
	
	internal class BeaconLogic extends ItemBase
	{
		private const MAXIMUM_CONSTRUCTION:int = 50;
		
		private var flow:IUpdateDispatcher;
		
		public function BeaconLogic(cell:ICoordinated, foundations:GameElements) 
		{
			super(new BeaconView(foundations), new ExistenceCore(cell));
		}
		
		
		
	}

}