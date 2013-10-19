package ui.background 
{
	import game.world.clouds.CloudPiece;
	import game.world.clouds.CloudTexture;
	import starling.display.DisplayObjectContainer;
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
			
			this.addChild(new CloudTexture(100));
		}
	}

}