package game.actors 
{
	import game.actors.core.ActorStoragePlus;
	import chaotic.core.IUpdateDispatcher;
	import game.metric.CellXY;
	import game.metric.Metric;
	import chaotic.utils.XMLByClass;
	
	public class ActorsFeature
	{		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			new ActorStoragePlus(flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY(- 10000, -10000);
		}
	}

}