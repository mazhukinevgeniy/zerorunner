package game.items 
{
	import game.metric.CellXY;
	import game.metric.Metric;
	import game.utils.GameFoundations;
	import game.world.ISearcher;
	
	public class ActorsFeature
	{		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const addActor:String = "addActor";
		public static const moveActor:String = "moveActor";
		public static const removeActor:String = "removeActor";
		
		public function ActorsFeature(foundations:GameFoundations, world:ISearcher) 
		{
			new ActorStorage(foundations, world);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return Metric.getTmpCell( -10000, -10000);
		}
	}

}