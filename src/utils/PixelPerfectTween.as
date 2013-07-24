package utils 
{
	import starling.animation.Tween;
	
	public class PixelPerfectTween extends Tween
	{
		
		public function PixelPerfectTween(target:Object, time:Number, transition:Object="linear") 
		{
			super(target, time, transition);
			
			this.roundToInt = true;
		}
		
	}

}