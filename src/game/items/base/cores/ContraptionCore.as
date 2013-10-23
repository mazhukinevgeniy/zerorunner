package game.items.base.cores 
{
	import game.items.base.CoreBase;
	import game.items.base.ItemBase;
	import game.items.items_internal;
	
	public class ContraptionCore extends CoreBase
	{
		private var constructionTarget:int;
		
		private var constructionStatus:int;
		
		public function ContraptionCore(item:ItemBase, maximum:int) 
		{
			super(item);
			
			this.constructionTarget = maximum;
			this.constructionStatus = 0;
			
			this.item.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
		}
		
		items_internal function applySoldering(value:int):void
		{
			this.constructionStatus += value;
			this.item.view.showConstruction(this.constructionStatus / this.MAXIMUM_CONSTRUCTION);
			
			if (this.constructionStatus > this.MAXIMUM_CONSTRUCTION && !this.reported)
			{
				this.reported = true;
				this.flow.dispatchUpdate(Update.smallBeaconTurnedOn);
			}
		}
		
		public function get progress():Number
		{
			return Number(this.constructionStatus / this.constructionTarget);
		}
	}

}