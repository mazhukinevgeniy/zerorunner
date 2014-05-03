package game.ui 
{
	import game.GameElements;
	import game.ui.renderer.Renderer;
	
	public class GameUI 
	{
		public var gameMenu:IGameMenu;
		
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