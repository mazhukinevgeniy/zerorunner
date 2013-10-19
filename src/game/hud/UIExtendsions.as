package game.hud 
{
	import game.core.GameElements;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameElements) 
		{
			new EndGameView(foundations);
			
			
			new MapFeature(foundations);
		}
		
	}

}