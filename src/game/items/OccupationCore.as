package game.items 
{
	
	public class OccupationCore 
	{
		
		public function OccupationCore() 
		{
			
		}
		
		item_exposure function tryMove():Boolean
		{
			return false;
		}
		
		item_exposure function tryShock():Boolean
		{
			return false;
		}
		
		item_exposure function trySoldering(value:int):Boolean
		{
			return false;
		}
	}

}