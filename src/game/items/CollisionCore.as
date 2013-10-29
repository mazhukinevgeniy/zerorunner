package game.items 
{
	import game.items.ItemBase;
	import game.items.items_internal;
	
	public class CollisionCore extends CoreBase
	{
		
		public function CollisionCore(item:ItemBase) 
		{
			super(item);
		}
		
		items_internal function collideWith(blocker:ItemBase):void
		{
			
		}
	}

}