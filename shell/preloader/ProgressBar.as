package preloader 
{
	import flash.display.Sprite;
	
	public class ProgressBar extends Sprite
	{
		private static const WIDTH:Number = 300;
		private static const HEIGHT:Number = 15;
		
		private var color:uint;
		private var countBar:int;
		private var drawBar:int;
		
		public function ProgressBar(newCountBar:int) 
		{
			this.color = 0x987650;
			this.countBar = newCountBar - 1;
			this.drawBar = 0;
			
			this.x = int(Main.WIDTH / 2 - ProgressBar.WIDTH/ 2);
			this.y = int(Main.HEIGHT / 2);
			
			this.redraw()
			
			this.useHandCursor = false;
			this.mouseChildren = false;
		}
		
		public function redraw():void
		{
			this.graphics.clear();
			this.graphics.beginFill(this.color);
			this.graphics.drawRect(0, 0, ProgressBar.WIDTH * this.drawBar / this.countBar , ProgressBar.HEIGHT);
			this.graphics.endFill();
			
			this.drawBar++;
		}
		
	}

}