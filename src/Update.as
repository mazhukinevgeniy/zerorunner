package  
{
	import utils.errors.StaticClassError;
	
	public class Update 
	{
		public static const addKeyboardEventListenersTo:String = "addKeyboardEventListenersTo";
		
		
		public static const addToTheHUD:String = "addToTheHUD";
		
		public static const prerestore:String = "prerestore"; //TODO: check if required
		public static const restore:String = "restore";
		
		public static const gameOver:String = "gameOver";
		public static const quitGame:String = "quitGame";
		
		public static const setGameContainer:String = "setGameContainer";
		
		
		public static const redraw:String = "redraw";
		public static const tick:String = "tick";
		public static const aftertick:String = "aftertick";
		
		public static const setPause:String = "setPause";
		
		public static const setHeroHP:String = "setHeroHP";
		public static const heroDamaged:String = "heroDamaged";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const addActor:String = "addActor";
		public static const moveActor:String = "moveActor";
		public static const removeActor:String = "removeActor";
		
		
		
		public static const addCacher:String = "addCacher";
		
		public static const newGame:String = "newGame";
		
		public static const openWindow:String = "openWindow";
		
		
		public static const keyUp:String = "keyUp";
		
		public static const panel_RollOut:String = "panel_RollOut";
		public static const panel_RollOver:String = "panel_RollOver";
		
		public static const unlockAchievement:String = "unlockAchievement";
		
		
		public static const emitStatistics:String = "emitStatistics";
		
		public static const showStatistics:String = "showStatistics";
		public static const hideStatistics:String = "hideStatistics";
		
		public static const cacheScene:String = "cacheScene";
		public static const cacheActors:String = "cacheActors";
		
		public function Update() 
		{
			throw new StaticClassError();
		}
		
	}

}