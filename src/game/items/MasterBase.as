package game.items 
{
	
	use namespace items_internal;
	
	public class MasterBase 
	{
		
		public function MasterBase() 
		{
			
		}
		
		
		
		internal function actOn(puppet:PuppetBase):void
		{
			this.act(puppet);
		}
		
		protected function act(puppet:PuppetBase):void
		{
			
		}
		
		
		items_internal function tryDestructionOn(puppet:PuppetBase):Boolean
		{
			puppet.forceDestruction();
			
			return true;
		}
		
		items_internal function tryMoveOn(puppet:PuppetBase):Boolean
		{
			return false; //TODO: use or delete
		}
		
	}

}