package  
{
	import chaotic.ZeroRunner;
	import controller.IController;
	import controller.MainController;
	import model.Data;
	import starling.display.Sprite;
	import view.View;
	
	public class Root extends Sprite
	{
		
		public function Root() 
		{
			var view:View = new View(this);
			
			var game:ZeroRunner = new ZeroRunner((view).getGameContainer(), (view).getAssets());
			
			var model:Data = new Data(game);
		}
		
	}

}