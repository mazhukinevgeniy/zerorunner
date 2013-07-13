package game.actors.modules 
{
	import game.actors.core.ActorBase;
	import game.actors.modules.pull.ActorPull;
	
	public class ActorManipulator
	{
		private var pool:ActorPull;
		
		public function ActorManipulator() 
		{
			
		}
		
		public function refill(vector:Vector.<ActorBase>):void
		{
			var length:int = vector.length;
			var actor:ActorBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = vector[i];
				
				if (!actor.active)
				{
					this.pool.stash(actor);
					
					vector[i] = this.pool.getActor();
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