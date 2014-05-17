package  
{
	import starling.utils.Color;
	
	public class View 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		
		public static const SOUND_EFFECT:int = 0;
		public static const SOUND_MUSIC:int = 1;
		
		public static const NUMBER_OF_SOUND_TYPES:int = 2;
		
		
		public static const MAIN_ATLAS:String = "mainAtlas";
		public static const MAIN_OFFSETS:String = "mainOffsets";
		
		
		public static const GAME_SCREEN:String = "gameScreen";
		public static const GAME_SCREEN_MENU:String = "menuScreen";
		public static const GAME_SCREEN_MAP:String = "mapScreen";
		public static const GAME_SCREEN_WON:String = "wonScreen";
		public static const GAME_SCREEN_LOST:String = "lostScreen";
		
		
		public static const SHELL_SCREEN_MAIN:String = "mainScreen";
		public static const SHELL_SCREEN_OPTIONS:String = "optionsScreen";
		public static const SHELL_SCREEN_MEMORIES:String = "memoriesScreen";
		public static const SHELL_SCREEN_CREDITS:String = "creditsScreen";
		
		
		public static const STAGE_COLOR:uint = Color.WHITE;
		
		
		public static const CELL_WIDTH:int = 70;
		public static const CELL_HEIGHT:int = 70;
		
		public static const CELLS_IN_VISIBLE_WIDTH:int = int(View.WIDTH / View.CELL_WIDTH);
		public static const CELLS_IN_VISIBLE_HEIGHT:int = int(View.HEIGHT / View.CELL_HEIGHT);
		
		
		public static const MEMORY_VIEW_WIDTH:int = 65;
		
		public function View() 
		{
			throw new Error("do not call");
		}
		
	}

}