package view.game 
{
	import binding.IBinder;
	import starling.display.DisplayObjectContainer;
	import view.game.renderer.Renderer;
	
	public function initializeGameView(binder:IBinder, root:DisplayObjectContainer):void
	{
		new Renderer(binder, root);
		
		/*new FuelView(elements);
		new MapFeature(elements);
		
		this.gameMenu = new GameMenu(elements);
		new EndGameView(elements);*/
		//TODO: do
	}
	
}