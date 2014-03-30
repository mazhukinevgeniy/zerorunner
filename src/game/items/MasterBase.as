package game.items 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class MasterBase 
	{
		
		public function MasterBase(elements:GameElements) 
		{
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
		}
		
		final update function restore(config:GameConfig):void
		{
			this.gameStarted();
		}
		
		protected function gameStarted():void
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