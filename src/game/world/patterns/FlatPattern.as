package game.world.patterns 
{
	import game.world.cache.SceneFeature;
	
	public class FlatPattern implements IPattern
	{
		
		public function FlatPattern() 
		{
			
		}
		
		public function getNumber(x:int, y:int):int
		{
			return SceneFeature.ROAD;
		}
	}

}