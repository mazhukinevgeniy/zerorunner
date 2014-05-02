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
		public static const ITEM_SHARD:int = 2;
		public static const ITEM_CHECKPOINT:int = 3;
		public static const ITEM_THE_GOAL:int = 4;
		
		public static const NUMBER_OF_ITEM_TYPES:int = 5;
		
		/* Landscape types */
		
		public static const SCENE_FALL:int = 0;
		public static const SCENE_GROUND:int = 1;
		public static const SCENE_TL_DISK:int = 2;
		public static const SCENE_BL_DISK:int = 3;
		public static const SCENE_TR_DISK:int = 4;
		public static const SCENE_BR_DISK:int = 5;
		public static const SCENE_UNUSED_1:int = 6;
		public static const SCENE_UNUSED_2:int = 7;
		
		/* Endings */
		
		public static const ENDING_LOST:int = 0;
		public static const ENDING_WON:int = 1;
		public static const ENDING_ABANDONED:int = 2;
		
		/* Frames */
		
		public static const FRAME_TO_ACT:int = 0;
		public static const FRAME_TO_UNLOCK_ACHIEVEMENTS:int = 1;
		public static const FRAME_TO_RUN_CATACLYSM:int = 2;
		public static const FRAME_UNUSED_FRAME_1:int = 3;
		public static const FRAME_UNUSED_FRAME_2:int = 4;
		
		public static const FRAMES_PER_CYCLE:int = 5;
		public static const TIME_BETWEEN_TICKS:Number = Game.FRAMES_PER_CYCLE / Main.FPS;
		
		/* Occupations */
		
		public static const OCCUPATION_FREE:int = 0;
		public static const OCCUPATION_MOVING:int = 1;
		public static const OCCUPATION_FLOATING:int = 2;
		public static const OCCUPATION_FLYING:int = 3;
		public static const OCCUPATION_DYING:int = 4;
		public static const OCCUPATION_UNSTABLE:int = 5;
		
		public static const NUMBER_OF_ITEM_OCCUPATIONS:int = 6;
		
		/* Projectiles */
		
		public static const PROJECTILE_SHARD:int = 0;
		
		public static const MAX_PROJ_HEIGHT:int = 60;
		
		/* Constants */
		
		public static const MAP_WIDTH:int = 90;
		
		public static const STAGE_COLOR:uint = 0x222222;
		//TODO: get art director to get the best color for that
		
		/* Metric */
		
		public static const CELL_WIDTH:int = 70;
		public static const CELL_HEIGHT:int = 70;
		
		public static const CELLS_IN_VISIBLE_WIDTH:int = int(Main.WIDTH / Game.CELL_WIDTH);
		public static const CELLS_IN_VISIBLE_HEIGHT:int = int(Main.HEIGHT / Game.CELL_HEIGHT);
		
		public function Game() 
		{
			throw new Error();
		}
		
		/* Functions */
		
		public static function distance(p1:ICoordinated, p2:ICoordinated):int
		{
			var x1:int = p1.x, x2:int = p2.x;
			var y1:int = p1.y, y2:int = p2.y;
			
			var xd1:int = Math.abs(x1 - x2);
			var xd2:int = Game.MAP_WIDTH - xd1;
			
			var yd1:int = Math.abs(y1 - y2);
			var yd2:int = Game.MAP_WIDTH - yd1;
			
			return Math.max(Math.min(xd1, xd2), Math.min(yd1, yd2));
		}
		
	}

}