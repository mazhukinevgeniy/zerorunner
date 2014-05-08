package view.game 
{
	import binding.IBinder;
	import starling.display.DisplayObjectContainer;
	import view.game.renderer.Renderer;
	
	public function initializeGameView(binder:IBinder, root:DisplayObjectContainer):void
	{
		new Renderer(binder, root);
		
		new MapFeature(binder, root);
		
		/*
		this.gameMenu = new GameMenu(elements);
		new EndGameView(elements);*/
		//TODO: do
	}
	
}