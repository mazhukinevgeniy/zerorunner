package game.items.beacon 
{
	import game.core.metric.*;
	import game.GameElements;
	import game.items.base.ISolderable;
	import game.items.base.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	internal class BeaconLogic extends ItemLogicBase
	{
		private const MAXIMUM_CONSTRUCTION:int = 50;
		
		private var flow:IUpdateDispatcher;
		private var view:BeaconView;
		
		private var reported:Boolean;
		
		public function BeaconLogic(foundations:GameElements) 
		{
			this.flow = foundations.flow;
			
			super(this.view = new BeaconView(foundations), foundations);
			
			super.reset();
			
			this.reported = false;
			
			this.constructionStatus = 0;
			this.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		
		
	}

}