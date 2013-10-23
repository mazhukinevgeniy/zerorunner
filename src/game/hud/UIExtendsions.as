package game.hud 
{
	import game.GameElements;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(elements:GameElements) 
		{
			new EndGameView(elements);
			
			
			new MapFeature(elements);
		}
		
	}

}