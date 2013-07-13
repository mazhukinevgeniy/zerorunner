package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	
	public class ActorPull 
	{
		private var types:Vector.<Class> = new <Class>[Character, Destroyer, Guardian, Hunter];
		
		public function ActorPull() 
		{
			
		}
		
		public function stash(actor:ActorBase):void
		{
			// TODO: do
		}
		
		public function getActor():ActorBase
		{
			// TODO: do
		}
		
		private function chooseTypeToReturn(id:int):int
		{
			//it'll be great if return type is always zero for the id zero
		}
	}

}