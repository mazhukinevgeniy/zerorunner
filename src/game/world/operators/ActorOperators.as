package game.world.operators 
{
	import game.core.GameFoundations;
	import game.world.items.utils.IPointCollector;
	
	public class ActorOperators 
	{
		
		public function ActorOperators(foundations:GameFoundations, points:IPointCollector) 
		{
			new ActFeature(foundations, points);
			new ClearFeature(foundations);
		}
		
	}

}