package game.hud 
{
	import game.hud.map.MapFeature;
	import game.hud.panel.Panel;
	import game.utils.GameFoundations;
	import utils.updates.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			new GameOverWindow(flow);
			new PauseView(flow);
			new Panel(flow);
			
			
			new MapFeature(foundations);
		}
		
	}

}