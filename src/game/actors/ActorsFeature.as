package game.actors 
{
	import game.actors.core.ActorStoragePlus;
	import game.actors.view.ActiveCanvas;
	import chaotic.core.IUpdateDispatcher;
	import game.metric.CellXY;
	import game.metric.Metric;
	import chaotic.utils.XMLByClass;
	
	public class ActorsFeature
	{
		public static const CHARACTER:int = 0;
		public static const DOG:int = 1;
		public static const MECHANIC:int = 2;
		public static const RESEARCH_DROID:int = 3;
		public static const BATTLE_DROID:int = 4;
		
		
		public static const addActor:String = "addActor";
		public static const moveActor:String = "moveActor";
		public static const removeActor:String = "removeActor";
		
		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const PROTAGONIST_ID:int = 0;
		
		
		public static const MAXIMUM_DAMAGE:int = 1000;
		
		public static const CAP:int = 500;
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			var view:ActiveCanvas = new ActiveCanvas(flow);
			new ActorStoragePlus(view, flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY(- 10000, -10000);
		}
	}

}