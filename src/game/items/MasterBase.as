package game.items 
{
	
	use namespace items_internal;
	
	public class MasterBase 
	{
		
		public function MasterBase() 
		{
			
		}
		
		items_internal function tryDestructionOn(puppet:PuppetBase):void
		{
			puppet.forceDestruction();
		}
		
		
		
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