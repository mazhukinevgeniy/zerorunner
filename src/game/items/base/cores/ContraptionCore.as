package game.items.base.cores 
{
	import game.items.base.CoreBase;
	import game.items.base.ItemBase;
	import game.items.items_internal;
	
	use namespace items_internal;
	
	public class ContraptionCore extends CoreBase
	{
		protected var constructionTarget:int;
		protected var constructionStatus:int;
		
		public function ContraptionCore(item:ItemBase, maximum:int) 
		{
			super(item);
			
			this.constructionTarget = maximum;
			this.constructionStatus = 0;
			
			this.item.view.showConstruction(this.constructionStatus / this.constructionTarget);
		}
		
		items_internal function applySoldering(value:int):void
		{
			this.constructionStatus += value;
			this.item.view.showConstruction(this.constructionStatus / this.constructionTarget);
		}
		
		public function get progress():Number
		{
			return Number(this.constructionStatus / this.constructionTarget);
		}
	}

}