package game.items.base 
{
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
		}
		
		items_internal function applySoldering(value:int):void
		{
			this.constructionStatus += value;
		}
		
		items_internal function get finished():Boolean
		{
			return this.progress >= 1;
		}
		
		protected function get progress():Number
		{
			return Number(this.constructionStatus / this.constructionTarget);
		}
	}

}