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
		
		
		final items_internal function tryMoveOn(puppet:PuppetBase):Boolean
		{
			return false;
		}
		
		final items_internal function tryShockOn(puppet:PuppetBase):Boolean
		{
			return false;
		}
	}

}