package  
{
	import game.metric.ICoordinated;
	
	/**
	 * Collection of global game-related constants, codes etc
	 */
	public class Game 
	{		
		/* Object types */
		
		public static const ITEM_CHARACTER:int = 0;
		public static const ITEM_BEACON:int = 1;
		public static const ITEM_DROID:int = 2;
		public static const ITEM_SHARD:int = 3;
		
		public static const NUMBER_OF_ITEM_TYPES:int = 4;
		
		/* Landscape types */
		
		public static const SCENE_FALL:int = 0;
		public static const SCENE_GROUND:int = 1;
		public static const SCENE_SOLID_GROUND:int = 2;
		public static const SCENE_LAVA:int = 3;
		
		/* Endings */
		
		public static const ENDING_LOST:int = 0;
		public static const ENDING_WON:int = 1;
		public static const ENDING_ABANDONED:int = 2;
		
		/* Frame types */
		
		public static const FRAME_TO_ACT:int = 0;
		public static const FRAME_TO_UNLOCK_ACHIEVEMENTS:int = 1;
		public static const FRAME_TO_RUN_CATACLYSM:int = 2;
		public static const FRAME_UNUSED_FRAME_1:int = 3;
		public static const FRAME_UNUSED_FRAME_2:int = 4;
		
		/* Occupations */
		
		public static const OCCUPATION_FREE:int = 0;
		public static const OCCUPATION_MOVING:int = 1;
		public static const OCCUPATION_FLOATING:int = 2;
		public static const OCCUPATION_FLYING:int = 3;
		public static const OCCUPATION_DYING:int = 4;
		
		public static const NUMBER_OF_ITEM_OCCUPATIONS:int = 5;
		
		/* Projectiles */
		
		public static const PROJECTILE_SHARD:int = 0;
		
		public static const MAX_PROJ_HEIGHT:int = 60;
		
		/* Constants */
		
		public static const MAP_WIDTH:int = 450;
		
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
		
		
		//TODO: check if achievement background is broken after achievements return to develop
	}

}