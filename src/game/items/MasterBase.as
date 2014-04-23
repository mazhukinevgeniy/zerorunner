package game.items 
{
	import game.GameElements;
	
	use namespace items_internal;
	
	public class MasterBase 
	{
		protected var elements:GameElements;
		
		public function MasterBase(elements:GameElements) 
		{
			this.elements = elements;
		}
		
		public function spawnPuppet(x:int, y:int):void
		{
			throw new Error("must implement");
		}
		
		
		internal function actOn(puppet:PuppetBase):void
		{
			if (puppet.occupation != Game.OCCUPATION_DYING)
				this.act(puppet);
		}
		
		protected function act(puppet:PuppetBase):void
		{
			
		}
	}

}