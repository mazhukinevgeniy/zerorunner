package native_controls 
{
	import flash.display.Sprite;
	
	public class ProgressBar extends Sprite
	{
		private static const WIDTH:Number = 300;
		private static const HEIGHT:Number = 15;
		
		private var color:uint;
		
		public function ProgressBar() 
		{
			this.color = 0x987650;
			
			this.x = int(Main.WIDTH / 2 - ProgressBar.WIDTH/ 2);
			this.y = int(Main.HEIGHT / 2);
			
			this.useHandCursor = false;
			this.mouseChildren = false;
		}
		
		public function redraw(ratio:Number):void
		{
			this.graphics.clear();
			this.graphics.beginFill(this.color);
			this.graphics.drawRect(0, 0, ProgressBar.WIDTH * ratio, ProgressBar.HEIGHT);
			this.graphics.endFill();
		}
		
	}

}