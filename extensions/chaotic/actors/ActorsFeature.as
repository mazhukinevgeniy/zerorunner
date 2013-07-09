package chaotic.actors 
{
	import chaotic.actors.manipulator.ActorManipulator;
	import chaotic.actors.spawner.ActorSpawner;
	import chaotic.actors.storage.ActorStorage;
	import chaotic.actors.view.ActiveCanvas;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.metric.CellXY;
	import chaotic.metric.Metric;
	
	public class ActorsFeature
	{
		public static const CAP:int = 150;
		
		public static const MAX_SPAWN_ONCE:int = 15;
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			var storage:ActorStorage = new ActorStorage(flow);
			
			new ActorSpawner(storage, flow);
			new ActorManipulator(storage, flow);
			new ActiveCanvas(flow);
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY((Metric.WIDTH - 1) / 2, (Metric.HEIGHT - 1) / 2);
		}
	}

}