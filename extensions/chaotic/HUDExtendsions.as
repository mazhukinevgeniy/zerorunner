package chaotic 
{
	import chaotic.camera.Camera;
	import chaotic.core.FeaturePack;
	import chaotic.endings.GrindedToDeath;
	import chaotic.input.InputFeatures;
	import chaotic.pause.PauseView;
	
	public class HUDExtendsions extends FeaturePack
	{
		
		public function HUDExtendsions() 
		{
			this.list.push(new Camera());
			this.list.push(new InputFeatures());
			this.list.push(new GrindedToDeath());
			this.list.push(new PauseView());
		}
		
	}

}