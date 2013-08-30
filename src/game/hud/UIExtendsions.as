package game.hud 
{
	import game.core.GameFoundations;
	import game.hud.map.MapFeature;
	import game.hud.panel.Panel;
	import utils.updates.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			new GameOverWindow(flow);
			new GameWonWindow(foundations);
			new PauseView(flow);
			new Panel(flow);
			
			
			new MapFeature(foundations);
		}
		
	}

}