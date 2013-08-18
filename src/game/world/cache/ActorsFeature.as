package game.world.cache 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.Metric;
	import game.world.broods.IGiveBroods;
	
	public class ActorsFeature
	{
		
		public function ActorsFeature(foundations:GameFoundations, broods:IGiveBroods) 
		{
			new ActorStorage(foundations, broods);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return Metric.getTmpCell( -10000, -10000);
		}
	}

}