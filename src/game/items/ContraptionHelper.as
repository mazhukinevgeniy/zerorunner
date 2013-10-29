package game.items 
{
	import game.items.ItemBase;
	import game.items.items_internal;
	
	use namespace items_internal;
	
	public class ContraptionHelper extends OccupationCore
	{
		protected var constructionTarget:int;
		protected var constructionStatus:int;
		
		public function ContraptionHelper(item:ItemBase, maximum:int) 
		{
			super(item);
			
			this.constructionTarget = maximum;
			this.constructionStatus = 0;
		}
		
		override items_internal function trySoldering(value:int):Boolean
		{
			this.constructionStatus += value;
			
			return true;
		}
		
		
		
		final protected function get progress():Number
		{
			return Number(this.constructionStatus / this.constructionTarget);
		}
		final protected function get finished():Boolean
		{
			return this.progress >= 1;
		}
	}

}