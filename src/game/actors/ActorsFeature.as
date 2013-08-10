package game.actors 
{
	import game.metric.CellXY;
	import game.metric.Metric;
	import utils.updates.IUpdateDispatcher;
	
	public class ActorsFeature
	{		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const addActor:String = "addActor";
		public static const moveActor:String = "moveActor";
		public static const removeActor:String = "removeActor";
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			new ActorStorage(flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY(-10000, -10000);
		}
	}

}