package game.world.operators 
{
	import game.world.IActors;
	import game.world.items.IPointCollector;
	import utils.updates.IUpdateDispatcher;
	
	public class ActorOperators 
	{
		
		public function ActorOperators(actors:IActors, flow:IUpdateDispatcher, points:IPointCollector) 
		{
			new Act(actors, flow, points);
			new Clear(actors, flow);
		}
		
	}

}