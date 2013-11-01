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
		
		
		
		final items_internal function tryMove():Boolean
		{
			return false;
		}
		
		final items_internal function tryShock():Boolean
		{
			return false;
		}
	}

}