package view.shell.controls 
{
	import binding.IBinder;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	import view.shell.clouds.Clouds;
	
	public class Background extends Sprite
	{
		
		public function Background(binder:IBinder) 
		{
			super();
			
			this.addChild(new Quad(View.WIDTH, View.HEIGHT, Color.SILVER));
			this.addChild(new Clouds(binder));
		}
	}

}