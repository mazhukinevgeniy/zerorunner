package ui.background 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	
	public class Background extends Quad
	{
		public function Background(root:DisplayObjectContainer) 
		{
			super(Main.WIDTH, Main.HEIGHT, 0x344322);
			
			root.addChild(this);
		}
	}

}