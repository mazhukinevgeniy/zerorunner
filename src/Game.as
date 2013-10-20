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
		public static const BASALT:int = 2;
		public static const LAVA:int = 3;
		
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
		
		/* Endings */
		
		public static const LOST:int = 0;
		public static const WON:int = 1;
		public static const ABANDONED:int = 2;
		
		/* Frame types */
		
		public static const FRAME_TO_CLEAR_BORDERS:int = 0;
		public static const FRAME_TO_UNLOCK_ACHIEVEMENTS:int = 1;
		public static const FRAME_TO_REDRAW:int = 2;
		public static const FRAME_TO_ACT:int = 3;
		public static const UNUSED_FRAME_1:int = 4;
		
		
		/* Constants */
		
		public static const BORDER_WIDTH:int = 10;
		
		public static const LEVEL_CAP:int = 3;
		
		
		
		public function Game() 
		{
			throw new Error();
		}
		
		
		//TODO: Die more.
		//TODO: move the package: game.world.cloud -> game.cloud
	}

}