package game.ui 
{
	import game.ui.panel.Panel;
	import utils.updates.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(flow:IUpdateDispatcher) 
		{
			new KeyboardControls(flow);
			new HealthBar(flow);
			new GameOverWindow(flow);
			new PauseView(flow);
			new Panel(flow);
		}
		
	}

}