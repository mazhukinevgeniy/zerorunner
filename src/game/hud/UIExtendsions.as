package game.hud 
{
	import game.core.GameFoundations;
	import game.hud.map.MapFeature;
	import utils.updates.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			new GameOverWindow(flow);
			new GameWonWindow(foundations);
			
			
			new MapFeature(foundations);
		}
		
	}

}