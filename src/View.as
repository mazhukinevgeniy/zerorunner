package  
{
	import starling.utils.Color;
	
	public class View 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		
		public static const SCREEN_MAIN:String = "mainScreen";
		public static const SCREEN_OPTIONS:String = "optionsScreen";
		public static const SCREEN_TROPHIES:String = "trophiesString";
		public static const SCREEN_CREDITS:String = "creditsString";
		
		
		public static const CLOUD_WIDTH:int = 700;
		
		
		public static const STAGE_COLOR:uint = Color.WHITE;
		
		
		public static const CELL_WIDTH:int = 70;
		public static const CELL_HEIGHT:int = 70;
		
		
		public static const CELLS_IN_VISIBLE_WIDTH:int = int(View.WIDTH / View.CELL_WIDTH);
		public static const CELLS_IN_VISIBLE_HEIGHT:int = int(View.HEIGHT / View.CELL_HEIGHT);
		
		
		public function View() 
		{
			throw new Error("do not call");
		}
		
	}

}