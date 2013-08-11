package game.actors.utils 
{
	import game.world.ISearcher;
	import starling.animation.Juggler;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	
	public class InformerKit 
	{
		public var assets:AssetManager;
		public var juggler:Juggler;
		
		public var flow:IUpdateDispatcher;
		public var world:ISearcher;
		
		public function InformerKit() 
		{
			
		}
		
	}

}