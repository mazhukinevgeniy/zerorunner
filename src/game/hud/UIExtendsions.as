package game.hud 
{
	import game.core.GameFoundations;
	import game.hud.map.MapFeature;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameFoundations) 
		{
			new GameOverWindow(foundations);
			new GameWonWindow(foundations);
			
			
			new MapFeature(foundations);
		}
		
	}

}