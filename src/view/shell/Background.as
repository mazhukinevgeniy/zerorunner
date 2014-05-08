package view.shell 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Background extends Sprite
	{
		
		public function Background() 
		{
			super();
			
			this.addChild(new Quad(Main.WIDTH, Main.HEIGHT, Color.SILVER));
		}
	}

}