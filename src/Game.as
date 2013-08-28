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
		
		public static const TOWER:int = 0;
		public static const CHARACTER:int = 1;
		public static const ALWAYS_ACTIVE:int = 2;
		
		
		public static const SECTOR_WIDTH:int = 50;
		
		public static const FRAME_TO_CLEAR_BORDERS:int = 0;
		
		public function Game() 
		{
			throw new StaticClassError();
		}
		
	}

}