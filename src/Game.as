package  
{
	
	/**
	 * Collection of global game-related constants, codes etc
	 */
	public class Game 
	{		
		/* Object types */
		
		public static const ITEM_CHARACTER:int = 0;
		public static const ITEM_BEACON:int = 1;
		public static const ITEM_SHARD:int = 2;
		public static const ITEM_THE_GOAL:int = 3;
		public static const ITEM_THE_SPAWN:int = 4;
		
		public static const NUMBER_OF_ITEM_TYPES:int = 5;
		
		/* Collectible types */
		
		public static const COLLECTIBLE_SPAWN:int = 0;
		public static const COLLECTIBLE_GOAL:int = 1;
		
		public static const NUMBER_OF_COLLECTIBLES:int = 32;
		
		/* Action types */
		
		public static const ACTION_SKIP_FRAME:int = 0;
		
		public static const NUMBER_OF_ACTIONS:int = 1;
		
		/* Landscape types */
		
		public static const SCENE_FALL:int = 0;
		public static const SCENE_GROUND:int = 1;
		public static const SCENE_BRIDGE:int = 2;
		public static const SCENE_UNUSED_5:int = 3;
		public static const SCENE_UNUSED_4:int = 4;
		public static const SCENE_UNUSED_3:int = 5;
		public static const SCENE_UNUSED_2:int = 6;
		public static const SCENE_UNUSED_1:int = 7;
		
		public static const SCENE_NONE:int = 8;
		
		/* Directions */
		
		public static const DIRECTION_RIGHT:int = 0;
		public static const DIRECTION_TOP:int = 1;
		public static const DIRECTION_LEFT:int = 2;
		public static const DIRECTION_DOWN:int = 3;
		
		/* Endings */
		
		public static const ENDING_LOST:int = 0;
		public static const ENDING_WON:int = 1;
		public static const ENDING_ABANDONED:int = 2;
		
		/* Occupations */
		
		public static const OCCUPATION_FREE:int = 0;
		public static const OCCUPATION_MOVING:int = 1;
		public static const OCCUPATION_UNSTABLE:int = 2;
		
		public static const NUMBER_OF_ITEM_OCCUPATIONS:int = 3;
		
		/* Projectiles */
		
		public static const PROJECTILE_SHARD:int = 0;
		
		public static const MAX_PROJ_HEIGHT:int = 60;
		
		/* Constants */
		
		public static const MAP_WIDTH:int = 90;
		public static const ACTION_RADIUS:int = 10;
		
		public function Game() 
		{
			throw new Error();
		}
	}

}