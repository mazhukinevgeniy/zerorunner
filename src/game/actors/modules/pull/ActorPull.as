package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.state.IGameState;
	
	public class ActorPull 
	{
		private const TICKS_BEFORE_NEXT:int = 200;
		
		
		private var types:Vector.<Class> = new <Class>[Character, Destroyer, Guardian, Hunter];
		//TODO: reactivate extra species
		
		private var state:IGameState;
		
		public function ActorPull(state:IGameState)
		{
			this.state = state;
		}
		
		public function stash(actor:ActorBase):void
		{
			// TODO: do
		}
		
		public function getActor(id:int):ActorBase
		{
			// TODO: do
			
			return new this.types[this.chooseTypeToReturn(id)](id);
		}
		
		private function chooseTypeToReturn(id:int):int
		{
			return int(Boolean(id)) + 
						(id * id * this.state.ticksPassed) 
						% 
						Math.min(this.types.length - 1, 
								 1 + int(this.state.ticksPassed / this.TICKS_BEFORE_NEXT)); 
			//TODO: remove odd/even assimethry
		}
	}

}