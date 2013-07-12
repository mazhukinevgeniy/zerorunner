package ui.windows 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import chaotic.core.IUpdateDispatcher;
	
	public class WindowBase extends Sprite
	{
		protected var flow:IUpdateDispatcher;
		
		public function WindowBase(width:int, height:int, centerAlign:Boolean = true) 
		{
			//временно, в будущем стоит сделать прозрачным
			var tmp:Quad = new Quad(width, height, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			if(centerAlign) this.centerAlignment();
		}
		
		private function centerAlignment():void
		{
			this.x = (ManagerWindows.WIDTH - this.width) / 2 + ManagerWindows.X;
			this.y = (Main.HEIGHT - this.height) / 2;
		}
		
	}

}