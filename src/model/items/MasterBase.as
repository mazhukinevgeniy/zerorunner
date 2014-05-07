package model.items 
{
	import game.GameElements;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class MasterBase
	{
		protected var elements:GameElements;
		
		public function MasterBase(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.quitGame);
		}
		
		update function quitGame():void { this.onGameFinished(); }
		
		
		internal function actOn(puppet:PuppetBase):void
		{
			if (puppet.occupation != Game.OCCUPATION_DYING)
				this.act(puppet);
		}
		
		
		protected function act(puppet:PuppetBase):void { }
		protected function onGameFinished():void { }
		
		
		public function spawnPuppet(x:int, y:int):void
		{
			throw new Error("must implement");
		}
	}

}