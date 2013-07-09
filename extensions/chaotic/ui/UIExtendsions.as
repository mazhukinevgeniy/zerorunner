package chaotic.ui 
{
	import chaotic.core.FeaturePack;
	import chaotic.updates.IUpdateDispatcher;
	
	public class UIExtendsions extends FeaturePack
	{
		
		public function UIExtendsions(flow:IUpdateDispatcher) 
		{
			this.list.push(new Camera(flow));
			this.list.push(new KeyboardControls(flow));
			this.list.push(new HealthBar(flow));
			this.list.push(new GrindedToDeath(flow));
			this.list.push(new PauseView(flow));
		}
		
	}

}