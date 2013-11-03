package game.items 
{
	
	use namespace items_internal;
	
	public class MasterBase 
	{
		
		public function MasterBase() 
		{
			
		}
		
		internal function applyDestruction():void
		{
			//this.items.removeItem(this);
		}//TODO: is it here?
		
		
		
		items_internal function actOn(puppet:PuppetBase):void
		{
			
		}		
		
		
		final items_internal function tryMove():Boolean
		{
			return false;
		}
		//TODO: fix them all
		final items_internal function tryShock():Boolean
		{
			return false;
		}
	}

}