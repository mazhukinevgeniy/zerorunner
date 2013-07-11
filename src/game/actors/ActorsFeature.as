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
		public static const addActor:String = "addActor";
		public static const moveActor:String = "moveActor";
		public static const detonateActor:String = "detonateActor";
		public static const jumpActor:String = "jumpActor";
		public static const damageActor:String = "damageActor";
		
		public static const actorRemoved:String = "actorRemoved";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const PROTAGONIST_ID:int = 0;
		
		[Embed(source = "actors.xml", mimeType="application/octet-stream")]
		internal static const config:Class;
		
		
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
		public static function get CONFIG():XML
		{
			return XMLByClass(ActorsFeature.config);
		}
	}

}