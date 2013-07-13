package game.actors 
{
	import game.actors.manipulator.ActorManipulator;
	import game.actors.spawner.ActorSpawner;
	import game.actors.storage.ActorStorage;
	import game.actors.view.ActiveCanvas;
	import chaotic.core.IUpdateDispatcher;
	import game.metric.CellXY;
	import game.metric.Metric;
	import chaotic.utils.XMLByClass;
	
	public class ActorsFeature
	{
		public static const actorAdded:String = "actorAdded";
		
		public static const actorJumped:String = "actorJumped";
		public static const actorMoved:String = "actorMoved";
		public static const actorDamaged:String = "actorDamaged";
		
		public static const actorDestroyed:String = "actorDestroyed";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const PROTAGONIST_ID:int = 0;
		
		
		public static const MAXIMUM_DAMAGE:int = 1000;
		
		
		public static const CAP:int = 100;
		
		public static const MAX_SPAWN_ONCE:int = 10;
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			var storage:ActorStorage = new ActorStorage(flow);
			
			new ActorSpawner(storage, flow);
			new ActorManipulator(storage, flow);
			new ActiveCanvas(flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY((Metric.WIDTH - 1) / 2, (Metric.HEIGHT - 1) / 2); //TODO: change for something like -9000, -9000
		}
	}

}