package chaotic.input 
{
	import chaotic.core.FeaturePack;
	
	public class InputFeatures extends FeaturePack
	{
		public function InputFeatures() 
		{
			this.list.push(new KeyboardControls());
		}
	}

}