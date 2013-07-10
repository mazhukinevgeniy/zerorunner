package ui.panel 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	internal class Body extends Sprite
	{
		internal static const HEIGHT:int = 26;
		
		public function Body() 
		{
			this.addChild(new Quad(Main.WIDTH, Body.HEIGHT, 0x222222));
			
			this.visible = false;
		}
		
	}

}