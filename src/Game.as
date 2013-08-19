package  
{
	import utils.errors.StaticClassError;
	
	/**
	 * Collection of global game-related constants, codes etc
	 */
	public class Game 
	{
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		
		
		public static const SECTOR_WIDTH:int = 50;
		
		
		
		public function Game() 
		{
			throw new StaticClassError();
		}
		
	}

}