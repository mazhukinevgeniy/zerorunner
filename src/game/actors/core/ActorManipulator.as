package game.actors.core 
{
	import game.actors.core.ActorBase;
	import game.actors.core.ActorStorage;
	import game.actors.core.pull.ActorPull;
	import game.actors.view.IActorListener;
	import game.state.IGameState;
	
	public class ActorManipulator extends ActorStorage
	{
		private var pool:ActorPull;
		private var listener:IActorListener;
		
		public function ActorManipulator(state:IGameState, listener:IActorListener) 
		{
			this.pool = new ActorPull(state);
			this.listener = listener;
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
						
						actor = vector[i];
						
						this.listener.actorSpawned(actor.getID(), actor.giveCell(), actor.getClassCode());
					}
				}
				else
				{
					vector[i] = this.pool.getActor(i);
					
					actor = vector[i];
					
					this.listener.actorSpawned(actor.getID(), actor.giveCell(), actor.getClassCode());
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