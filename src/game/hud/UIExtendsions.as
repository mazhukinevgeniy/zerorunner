package game.hud 
{
	import game.hud.panel.Panel;
	import utils.updates.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(flow:IUpdateDispatcher) 
		{
			new HealthBar(flow);
			new GameOverWindow(flow);
			new PauseView(flow);
			new Panel(flow);
		}
		
	}

}