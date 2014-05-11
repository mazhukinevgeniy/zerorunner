package view.shell.controls 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Background extends Sprite
	{
		
		public function Background() 
		{
			super();
			
			this.addChild(new Quad(View.WIDTH, View.HEIGHT, Color.SILVER));
		}
	}

}