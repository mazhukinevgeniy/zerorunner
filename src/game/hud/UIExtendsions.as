package game.hud 
{
	import game.core.GameFoundations;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameFoundations) 
		{
			new EndGameView(foundations);
			
			
			new MapFeature(foundations);
		}
		
	}

}