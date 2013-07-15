package game.actors.modules 
{
	import game.actors.core.ActorBase;
	import game.actors.modules.pull.ActorPull;
	import game.state.IGameState;
	
	public class ActorManipulator
	{
		private var pool:ActorPull;
		
		public function ActorManipulator(state:IGameState) 
		{
			this.pool = new ActorPull(state);
		}
		
		/**
		 * @param force If true, forces recreation of active actors as well
		**/
		public function refill(vector:Vector.<ActorBase>, force:Boolean = false):void
		{
			var length:int = vector.length;
			var actor:ActorBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = vector[i];
				
				if (actor)
				{
					if (!actor.active || force)
					{
						this.pool.stash(actor);
						
						vector[i] = this.pool.getActor(i);
					}
				}
				else
				{
					vector[i] = this.pool.getActor(i);
				}
			}
		}
		
		public function act(vector:Vector.<ActorBase>):void
		{
			var length:int = vector.length;
			
			for (var i:int = 0; i < length; i++)
				vector[i].act();
		}
		
	}

}