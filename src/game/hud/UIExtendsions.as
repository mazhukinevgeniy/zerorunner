package game.hud 
{
	import game.GameElements;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(foundations:GameElements) 
		{
			new EndGameView(foundations);
			
			
			new MapFeature(foundations);
		}
		
	}

}