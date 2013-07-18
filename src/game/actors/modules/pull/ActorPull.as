package game.actors.modules.pull 
{
	import game.actors.core.ActorBase;
	import game.state.IGameState;
	
	public class ActorPull 
	{
		private const TICKS_BEFORE_NEXT:int = 200;
		
		
		private var types:Vector.<Class> = new <Class>[Character, Dog, Guardian, Hunter];
		
		private var pull:Vector.<Vector.<ActorBase>>;
		
		private var state:IGameState;
		
		public function ActorPull(state:IGameState)
		{
			this.state = state;
			
			var length:int = this.types.length;
			this.pull = new Vector.<Vector.<ActorBase>>(length, true);
			
			for (var i:int = 0; i < length; i++)
			{
				this.pull[i] = new Vector.<ActorBase>();
			}
		}
		
		public function stash(actor:ActorBase):void
		{
			var length:int = this.types.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (actor is this.types[i])
				{
					this.pull[i].push(actor);
					return;
				}
			}
		}
		
		public function getActor(id:int):ActorBase
		{
			var actor:ActorBase;
			
			var type:int = this.chooseTypeToReturn(id);
			actor = this.pull[type].pop();
			
			if (!actor)
			{
				actor = new this.types[type]();
			}
			
			actor.reset(id);
			
			return actor;
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