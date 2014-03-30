package ui.windows 
{
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
	import ui.navigation.Navigation;
	
	public class Window extends ScrollContainer
	{
		
		public static const WIDTH:Number = Main.WIDTH - (Navigation.WIDTH + 20);
		public static const HEIGHT:Number = Main.HEIGHT - 20;
		
		public function Window() 
		{
			this.width = Window.WIDTH;
			this.height = Window.HEIGHT;
			this.x =(Main.WIDTH + Navigation.WIDTH - Window.WIDTH) / 2;
			this.y = (Main.HEIGHT - Window.HEIGHT) / 2;
			
			var background:Quad = new Quad(Window.WIDTH, Window.HEIGHT, 0xFFFFFF);
			background.alpha = 0.85;
			this.backgroundSkin = background;
		}
		
	}

}