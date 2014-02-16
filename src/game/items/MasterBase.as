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
			if (puppet.occupation != Game.OCCUPATION_DYING)
				this.act(puppet);
		}
		
		protected function act(puppet:PuppetBase):void
		{
			
		}
		
		
		final public function tryDestructionOn(puppet:PuppetBase):Boolean
		{
			puppet.forceDestruction();
			
			return true;
		}
		//TODO: this class is weird, fix it
	}

}