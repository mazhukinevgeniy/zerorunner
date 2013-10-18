package game.hud 
{
	import game.core.GameFoundations;
	import game.hud.map.MapFeature;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameFoundations) 
		{
			new EndGameView(foundations.flow);
			
			
			new MapFeature(foundations);
		}
		
	}

}