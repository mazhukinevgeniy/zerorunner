package preloader 
{
	import flash.display.Sprite;
	
	public class Background extends Sprite
	{
		
		public function Background()
		{
			this.graphics.beginFill(0xCCFF11, 0.5);
			this.graphics.drawRect(0, 0, Constants.WIDTH , Constants.HEIGHT);
			this.graphics.endFill();
		}
		
	}

}