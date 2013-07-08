package chaotic.ui 
{
	import chaotic.core.FeaturePack;
	
	public class UIExtendsions extends FeaturePack
	{
		
		public function UIExtendsions() 
		{
			this.list.push(new Camera());
			this.list.push(new KeyboardControls());
			this.list.push(new GrindedToDeath());
			this.list.push(new PauseView());
		}
		
	}

}