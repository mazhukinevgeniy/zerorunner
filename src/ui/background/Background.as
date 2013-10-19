package ui.background 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import utils.updates.IUpdateDispatcher;
	
	public class Background extends Sprite
	{
		
		public function Background(flow:IUpdateDispatcher) 
		{
			super();
			this.addChild(new Quad(Main.WIDTH, Main.HEIGHT, 0x344322));
			this.addChild(new ResetButton(flow));
		}
	}

}