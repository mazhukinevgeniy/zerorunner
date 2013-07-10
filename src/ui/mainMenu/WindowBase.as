package ui.mainMenu 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class WindowBase extends Sprite
	{
		
		public function WindowBase(width:int, height:int) 
		{
			var tmp:Quad = new Quad(width, height, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			this.x = (Main.WIDTH - this.width) / 2;
			this.y = (Main.HEIGHT - this.height) / 2;
		}
	}

}