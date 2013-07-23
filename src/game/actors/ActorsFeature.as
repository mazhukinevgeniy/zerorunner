package game.actors 
{
	import game.actors.core.ActorStorage;
	import game.actors.view.ActiveCanvas;
	import chaotic.core.IUpdateDispatcher;
	import game.metric.CellXY;
	import game.metric.Metric;
	import chaotic.utils.XMLByClass;
	
	public class ActorsFeature
	{
		public static const CHARACTER:int = 0;
		public static const DOG:int = 1;
		public static const HUNTER:int = 2;
		public static const MECHANIC:int = 3;
		public static const MINE:int = 4;
		public static const RESEARCH_DROID:int = 5;
		public static const ROBOT:int = 6;
		public static const ROCKET:int = 7;
		public static const TURRET:int = 8;
		
		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const PROTAGONIST_ID:int = 0;
		
		
		public static const MAXIMUM_DAMAGE:int = 1000;
		
		public static const CAP:int = 250;
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			var view:ActiveCanvas = new ActiveCanvas(flow);
			new ActorStorage(view, flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY(- 10000, -10000);
		}
	}

}