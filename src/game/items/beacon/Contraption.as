package game.items.beacon 
{
	import game.GameElements;
	import game.items.base.cores.ContraptionCore;
	import game.items.items_internal;
	import utils.updates.IUpdateDispatcher;
	
	use namespace items_internal;
	
	internal class Contraption extends ContraptionCore
	{
		private var flow:IUpdateDispatcher;
		private var reported:Boolean = false;
		
		public function Contraption(item:BeaconLogic, elements:GameElements) 
		{
			const MAXIMUM:int = 50;
			super(item, MAXIMUM);
			
			this.flow = elements.flow;
		}
		
		override items_internal function applySoldering(value:int):void
		{
			super.applySoldering(value:int);
			
			if (this.constructionStatus > this.constructionTarget && !this.reported)
			{
				this.reported = true;
				this.flow.dispatchUpdate(Update.smallBeaconTurnedOn);
			}
		}
	}

}