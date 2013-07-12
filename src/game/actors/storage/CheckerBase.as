package game.actors.storage 
{
	import game.grinder.IGrinder;
	import game.scene.IScene;
	
	internal class CheckerBase 
	{
		internal static var grinder:IGrinder;
		internal static var scene:IScene;
		internal static var searcher:ISearcher;
		
		public function CheckerBase() 
		{
			
		}
		
		final protected function get grinder():IGrinder
		{
			return CheckerBase.grinder;
		}
		final protected function get scene():IScene
		{
			return CheckerBase.scene;
		}
		final protected function get searcher():ISearcher
		{
			return CheckerBase.searcher;
		}
	}

}