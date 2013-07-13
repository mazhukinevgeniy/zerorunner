package game.actors.storage 
{
	import chaotic.core.IUpdateDispatcher;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class ActorBase 
	{
		internal static var flow:IUpdateDispatcher;
		internal static var searcher:ISearcher;
		internal static var grinder:IGrinder;
		internal static var scene:IScene;
		
		
		internal var type:int;
		internal var id:int;
		
		internal var cell:CellXY;
		
		internal var active:Boolean;
		
		public function ActorBase(configuration:XML) 
		{
			
		}
		
		
		public function get x():int
		{
			return this.cell.x;
		}
		public function get y():int
		{
			return this.cell.y;
		}
		
		
		
		
		
		
		
		final protected function get grinder():IGrinder
		{
			return ActorBase.grinder;
		}
		final protected function get scene():IScene
		{
			return ActorBase.scene;
		}
		final protected function get searcher():ISearcher
		{
			return ActorBase.searcher;
		}
	}

}