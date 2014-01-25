package  
{
	import game.core.metric.ICoordinated;
	
	/**
	 * Collection of global game-related constants, codes etc
	 */
	public class Game 
	{
		/* Object types */
		
		public static const ITEM_CHARACTER:int = 0;
		public static const ITEM_JUNK:int = 1;
		public static const ITEM_BEACON:int = 2;
		public static const ITEM_DROID:int = 3;
		
		public static const NUMBER_OF_ITEM_TYPES:int = 4;
		
		/* Landscape types */
		
		public static const SCENE_FALL:int = 0;
		public static const SCENE_ROAD:int = 1;
		public static const SCENE_BASALT:int = 2;
		public static const SCENE_LAVA:int = 3;
		
		/* What have you left types *///TODO: check if this comment makes sense
		
		public static const CONTRAIL_NO_BEACON:int = 0;
		public static const CONTRAIL_BIG_BEACON:int = 1;
		public static const CONTRAIL_SMALL_BEACON:int = 2;
		
		/* Endings */
		
		public static const ENDING_LOST:int = 0;
		public static const ENDING_WON:int = 1;
		public static const ENDING_ABANDONED:int = 2;
		
		/* Frame types */
		
		public static const FRAME_TO_ACT:int = 0;
		public static const FRAME_TO_CLEAR_BORDERS:int = 1;
		public static const FRAME_TO_UNLOCK_ACHIEVEMENTS:int = 2;
		public static const FRAME_TO_REDRAW:int = 3;
		public static const FRAME_UNUSED_FRAME_1:int = 4;
		
		/* Occupations */
		
		public static const OCCUPATION_FREE:int = 0;
		public static const OCCUPATION_MOVING:int = 1; //TODO: check if can remove
		public static const OCCUPATION_SHOCKING:int = 2;
		public static const OCCUPATION_DYING:int = 3;
		public static const OCCUPATION_MOVING_UP:int = 4;
		public static const OCCUPATION_MOVING_DOWN:int = 5;
		public static const OCCUPATION_MOVING_LEFT:int = 6;
		public static const OCCUPATION_MOVING_RIGHT:int = 7;
		public static const OCCUPATION_TAKING_SHOCK:int = 8;
		
		public static const NUMBER_OF_ITEM_OCCUPATIONS:int = 9;
		
		/* Constants */
		
		public static const MAP_WIDTH:int = 20;		
		public static const BORDER_WIDTH:int = 10;
		
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
		//TODO: check if achievement background is broken after achievements return to develop
	}

}