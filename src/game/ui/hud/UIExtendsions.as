package game.ui.hud 
{
	import game.GameElements;
	
	public class UIExtendsions
	{
		
		public function UIExtendsions(elements:GameElements) 
		{
			new FuelView(elements);
			new MapFeature(elements);
			
			new Panel(elements);
			new EndGameView(elements);
		}
		
	}

}