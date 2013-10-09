package  
{
	
	/**
	 * Collection of global game-related constants, codes etc
	 */
	public class Game 
	{
		/* Landscape types */
		
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		public static const ICE:int = 2;
		public static const WATER:int = 3;
		
		/* POI types */
		
		public static const TOWER:int = 0;
		public static const CHARACTER:int = 1;
		public static const ALWAYS_ACTIVE:int = 2;
		
		/* Beacon types */
		
		public static const NO_BEACON:int = 0;
		public static const BIG_BEACON:int = 1;
		public static const BEACON:int = 2;
		
		/* Goal types */
		
		public static const LIGHT_A_BEACON:int = 0;
		
		/* Frame types */
		
		public static const FRAME_TO_CLEAR_BORDERS:int = 0;
		public static const FRAME_TO_UNLOCK_ACHIEVEMENTS:int = 1;
		
		
		/* Temporary bad things */
		
		public static const SECTOR_WIDTH:int = 10;
		//TODO: parametrize
		
		public static const LEVELS_PER_RUN:int = 3;
		
		
		
		public function Game() 
		{
			throw new Error();
		}
		
		
		//TODO:
		/*
		
		Die more.
		
		
		
		
		*/
	}

}