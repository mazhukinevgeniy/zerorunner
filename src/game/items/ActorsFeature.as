package game.items 
{
	import game.broods.IGiveBroods;
	import game.metric.CellXY;
	import game.metric.Metric;
	import game.utils.GameFoundations;
	
	public class ActorsFeature
	{		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const addActor:String = "addActor";
		public static const moveActor:String = "moveActor";
		public static const removeActor:String = "removeActor";
		
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