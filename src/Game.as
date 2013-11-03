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
		
		public static const FRAME_TO_ACT:int = 0;
		public static const FRAME_TO_CLEAR_BORDERS:int = 1;
		public static const FRAME_TO_UNLOCK_ACHIEVEMENTS:int = 2;
		public static const FRAME_TO_REDRAW:int = 3;
		public static const UNUSED_FRAME_1:int = 4;
		
		/* Occupations */
		
		public static const FREE:int = 0;
		public static const MOVING:int = 1;
		public static const SHOCKING:int = 2;
		public static const DYING:int = 3;
		
		/* Constants */
		
		public static const BORDER_WIDTH:int = 10;
		
		public static const LEVEL_CAP:int = 3;
		//TODO: think if it's to be constant
		
		/* Time-related */
		
		public static const FRAMES_PER_CYCLE:int = 5;
		public static const TIME_BETWEEN_TICKS:Number = Game.FRAMES_PER_CYCLE / Main.FPS;
		
		/* Metric */
		
		public static const CELL_WIDTH:int = 40;
		public static const CELL_HEIGHT:int = 40;
		
		public static const CELLS_IN_VISIBLE_WIDTH:int = int(Main.WIDTH / Game.CELL_WIDTH);
		public static const CELLS_IN_VISIBLE_HEIGHT:int = int(Main.HEIGHT / Game.CELL_HEIGHT);
		
		public function Game() 
		{
			throw new Error();
		}
		
		
		//TODO: Die more.
	}

}