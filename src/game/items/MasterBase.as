package game.items 
{
	
	public class MasterBase 
	{
		
		public function MasterBase() 
		{
			
		}
		
		internal function applyDestruction():void
		{
			//this.items.removeItem(this);
		}//TODO: is it here?
		
		
		
		public function act():void
		{
			
		}
		
		
		
		final item_exposure function tryMove():Boolean
		{
			return false;
		}
		
		final item_exposure function tryShock():Boolean
		{
			return false;
		}
	}

}