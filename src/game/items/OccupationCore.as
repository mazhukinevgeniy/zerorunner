package game.items 
{
	import game.items.items_internal;
	
	public class OccupationCore 
	{
		
		public function OccupationCore() 
		{
			
		}
		
		items_internal function tryMove():Boolean
		{
			return false;
		}
		
		items_internal function tryShock():Boolean
		{
			return false;
		}
	}

}