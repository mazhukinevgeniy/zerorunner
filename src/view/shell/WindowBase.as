package view.shell 
{
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
	import ui.navigation.Navigation;
	
	public class WindowBase extends ScrollContainer
	{
		
		public static const WIDTH:Number = Main.WIDTH - (Navigation.WIDTH + 20);
		public static const HEIGHT:Number = Main.HEIGHT - 20;
		
		public function WindowBase() 
		{
			this.width = WindowBase.WIDTH;
			this.height = WindowBase.HEIGHT;
			this.x =(Main.WIDTH + Navigation.WIDTH - WindowBase.WIDTH) / 2;
			this.y = (Main.HEIGHT - WindowBase.HEIGHT) / 2;
			
			var background:Quad = new Quad(WindowBase.WIDTH, WindowBase.HEIGHT, 0xFFFFFF);
			background.alpha = 0.85;
			this.backgroundSkin = background;
		}
		
	}

}