package view.game 
{
	import game.GameElements;
	import game.Restorer;
	import game.ui.renderer.Renderer;
	
	public class GameUI 
	{
		
		public function GameUI(elements:GameElements) 
		{
			new Renderer(elements);
			
			new FuelView(elements);
			new MapFeature(elements);
			
			this.gameMenu = new GameMenu(elements);
			new EndGameView(elements);
			
			
			new GameTheme(elements.displayRoot, elements.assets.getTextureAtlas("sprites"));
		}
		
		
	}

}