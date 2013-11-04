package  
{
	import game.core.metric.ICoordinated;
	
	/**
	 * Collection of global game-related constants, codes etc
	 */
	public class Game 
	{
		/* Object types */
		
		public static const CHARACTER:int = 0;
		public static const JUNK:int = 1;
		public static const BEACON:int = 2;
		
		public static const NUMBER_OF_ITEM_TYPES:int = 3;
		
		/* Landscape types */
		
		public static const FALL:int = 0;
		public static const ROAD:int = 1;
		public static const BASALT:int = 2;
		public static const LAVA:int = 3;
		
		/* Beacon types */
		
		public static const NO_BEACON:int = 0;
		public static const BIG_BEACON:int = 1;
		public static const SMALL_BEACON:int = 2;
		
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
		public static const MOVING:int = 1; //TODO: check if can remove
		public static const SHOCKING:int = 2;
		public static const DYING:int = 3;
		public static const MOVING_UP:int = 4;
		public static const MOVING_DOWN:int = 5;
		public static const MOVING_LEFT:int = 6;
		public static const MOVING_RIGHT:int = 7;
		public static const TAKING_SHOCK:int = 8;
		
		public static const NUMBER_OF_ITEM_OCCUPATIONS:int = 9;
		
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
		
		/* Functions */
		
		public static function distance(p1:ICoordinated, p2:ICoordinated):int
		{
			return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y)
		}
		
		
		//TODO: Die more.
	}

}