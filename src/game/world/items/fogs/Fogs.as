package game.world.items.fogs 
{
	import game.core.GameFoundations;
	import game.world.items.fogs.clouds.Cloud;
	
	public class Fogs 
	{
		
		public function Fogs(foundations:GameFoundations) 
		{
			//TODO: initialize everything
			
			//DEBUG: like a test
			
			new FogPile(foundations);
			new Cloud();
		}
		
		//TODO: here be pooling of piles
	}

}