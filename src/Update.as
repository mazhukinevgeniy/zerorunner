package  
{
	import utils.errors.StaticClassError;
	
	public class Update 
	{
		public static const reparametrize:String = "reparametrize";
		
		public static const addToTheHUD:String = "addToTheHUD";
		
		public static const prerestore:String = "prerestore";
		public static const restore:String = "restore";
		
		public static const gameOver:String = "gameOver";
		public static const gameStopped:String = "gameStopped";
		public static const gameWon:String = "gameWon";
		public static const quitGame:String = "quitGame";
		
		public static const setGameContainer:String = "setGameContainer";
		
		
		public static const redraw:String = "redraw";
		public static const tick:String = "tick";
		
		public static const setPause:String = "setPause";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const newGame:String = "newGame";
		
		public static const openWindow:String = "openWindow";
		
		
		public static const keyUp:String = "keyUp";
		
		public static const panel_RollOut:String = "panel_RollOut";
		public static const panel_RollOver:String = "panel_RollOver";
		
		public static const unlockAchievement:String = "unlockAchievement";
		
		
		public static const emitStatistics:String = "emitStatistics";
		
		public static const showStatistics:String = "showStatistics";
		public static const hideStatistics:String = "hideStatistics";
		
		public static const discardClicks:String = "discardClicks";
		public static const discardInput:String = "discardInput";
		
		public static const freeFrame:String = "freeFrame";
		
		public static const resetProgress:String = "resetProgress";
		
		public function Update() 
		{
			throw new StaticClassError();
		}
		
	}

}