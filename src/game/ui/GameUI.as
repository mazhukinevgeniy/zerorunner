package game.ui 
{
	import game.GameElements;
	import game.ui.hud.UIExtendsions;
	import game.ui.renderer.Renderer;
	
	public class GameUI 
	{
		
		public function GameUI(elements:GameElements) 
		{
			new Renderer(elements);
			
			new UIExtendsions(elements);
			
			
			new GameTheme(elements.displayRoot, elements.assets.getTextureAtlas("sprites"));
		}
		
		
	}

}