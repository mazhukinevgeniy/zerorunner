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
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const PROTAGONIST_ID:int = 0;
		
		
		public static const MAXIMUM_DAMAGE:int = 1000;
		
		public static const CAP:int = 50;
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			var view:ActiveCanvas = new ActiveCanvas();
			var spawner:ActorSpawner = new ActorSpawner(view);
			new ActorStorage(view, spawner, flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY((Metric.WIDTH - 1) / 2, (Metric.HEIGHT - 1) / 2); //TODO: change for something like -9000, -9000
		}
	}

}