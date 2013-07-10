package game.ui 
{
	import chaotic.core.IUpdateDispatcher;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(flow:IUpdateDispatcher) 
		{
			new Camera(flow);
			new KeyboardControls(flow);
			new HealthBar(flow);
			new GrindedToDeath(flow);
			new PauseView(flow);
		}
		
	}

}