package game.items.utils 
{
	import game.items.IActors;
	import game.points.IPointCollector;
	import utils.updates.IUpdateDispatcher;
	
	public class ActorUtils 
	{
		private static var created:int = 0;
		
		public function ActorUtils(actors:IActors, flow:IUpdateDispatcher, points:IPointCollector) 
		{
			ActorUtils.created++;
			if (ActorUtils.created > 1)
				throw new Error();
			
			new Act(actors, flow, points);
			new Clear(actors, flow);
		}
		
	}

}