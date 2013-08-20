package game.world.operators 
{
	import game.world.broods.utils.IPointCollector;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	
	public class ActorOperators 
	{
		
		public function ActorOperators(flow:IUpdateDispatcher, world:ISearcher, points:IPointCollector) 
		{
			new ActFeature(flow, world, points);
		}
		
	}

}