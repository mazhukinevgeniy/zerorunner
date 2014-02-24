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
		
		override public function reset(target:Object, time:Number, transition:Object = "linear"):Tween
		{
			super.reset(target, time, transition);
			
			this.roundToInt = true;
			
			return this;
		}
	}

}