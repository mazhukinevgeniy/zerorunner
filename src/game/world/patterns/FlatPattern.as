package game.world.patterns 
{
	
	public class FlatPattern implements IPattern
	{
		
		public function FlatPattern() 
		{
			
		}
		
		public function getNumber(x:int, y:int):int
		{
			return Game.ROAD;
		}
	}

}