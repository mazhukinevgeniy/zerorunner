package game.items.beacon 
{
	import game.core.metric.*;
	import game.GameElements;
	import game.items.base.ISolderable;
	import game.items.base.ItemBase;
	import utils.updates.IUpdateDispatcher;
	
	internal class BeaconLogic extends ItemBase
	{
		private const MAXIMUM_CONSTRUCTION:int = 50;
		
		private var flow:IUpdateDispatcher;
		private var view:BeaconView;
		
		private var reported:Boolean;
		
		public function BeaconLogic(cell:ICoordinated, foundations:GameElements) 
		{
			this.flow = foundations.flow;
			
			super(cell, this.view = new BeaconView(foundations), foundations);
			
			super.reset();
			
			this.reported = false;
			
			this.constructionStatus = 0;
			this.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		
		
	}

}