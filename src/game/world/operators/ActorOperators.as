package game.world.operators 
{
	import game.world.IActors;
	import game.world.items.utils.IPointCollector;
	import utils.updates.IUpdateDispatcher;
	
	public class ActorOperators 
	{
		
		public function ActorOperators(actors:IActors, flow:IUpdateDispatcher, points:IPointCollector) 
		{
			new ActFeature(actors, flow, points);
			new ClearFeature(actors, flow);
		}
		
	}

}