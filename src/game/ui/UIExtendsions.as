package game.ui 
{
	import game.ui.camera.Camera;
	import game.ui.panel.Panel;
	import utils.updates.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(flow:IUpdateDispatcher) 
		{
			new Camera(flow);
			new KeyboardControls(flow);
			new HealthBar(flow);
			new GameOverWindow(flow);
			new PauseView(flow);
			new Panel(flow);
		}
		
	}

}