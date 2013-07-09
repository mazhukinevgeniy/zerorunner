package chaotic.actors 
{
	import chaotic.actors.manipulator.ActorManipulator;
	import chaotic.actors.spawner.ActorSpawner;
	import chaotic.actors.storage.ActorStorage;
	import chaotic.actors.view.ActiveCanvas;
	import chaotic.core.FeaturePack;
	import chaotic.metric.CellXY;
	import chaotic.metric.Metric;
	import chaotic.updates.IUpdateDispatcher;
	
	public class ActorsFeature extends FeaturePack
	{
		public static const CAP:int = 150;
		
		public static const MAX_SPAWN_ONCE:int = 15;
		
		public function ActorsFeature(flow:IUpdateDispatcher) 
		{
			var storage:ActorStorage = new ActorStorage(flow);
			
			this.list.push(storage);
			this.list.push(new ActorSpawner(storage, flow));
			this.list.push(new ActorManipulator(storage, flow));
			this.list.push(new ActiveCanvas(flow));
		}
		
		
		public static function get SPAWN_CELL():CellXY
		{
			return new CellXY((Metric.WIDTH - 1) / 2, (Metric.HEIGHT - 1) / 2);
		}
	}

}