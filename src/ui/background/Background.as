package ui.background 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class Background extends Sprite
	{
		
		public function Background() 
		{
			super();
			this.addChild(new Quad(Main.WIDTH, Main.HEIGHT, 0x344322));
		}
	}

}