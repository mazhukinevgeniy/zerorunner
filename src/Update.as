package  
{
	
	public class Update 
	{
		/* Input updates */
		
		public static const keyUp:String = "keyUp";
		
		
		/* Metagame updates */
		
		public static const newGame:String = "newGame";
		
		public static const prerestore:String = "prerestore";
		public static const restore:String = "restore";
		
		public static const gameStopped:String = "gameStopped";
		public static const quitGame:String = "quitGame";
		
		public static const tellRoundLost:String = "tellRoundLost";
		public static const tellRoundWon:String = "tellRoundWon";
		public static const tellGameWon:String = "tellGameWon";
		//TODO: it feels like methods, so, huh, implement it this way
		//TODO: btw, try to remove every method-like update. are there some?
		//TODO: btw-2, try to remove shortly used updates (aka "special" ones)
		
		
		/* In-game updates */
		
		public static const smallBeaconTurnedOn:String = "smallBeaconTurnedOn";
		public static const technicUnlocked:String = "technicUnlocked";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		
		/* Time updates */
		
		public static const numberedFrame:String = "numberedFrame"; //Method-like if divided instead of using with flags
		public static const redraw:String = "redraw"; //Method-like: used by renderer
		public static const tick:String = "tick"; //Method-like: used by actors
		//TODO: btw-3, remove inheretance between the actors and the scene
		
		
		/* Shell updates */
		
		public static const toggleMute:String = "toggleMute";
		public static const toggleWindow:String = "toggleWindow"; //Method-like: used by windowmanager
		
		public static const resetProgress:String = "resetProgress"; //Method-like: used by gamesave
		
		public static const dropMiss:String = "dropMiss";
		
		
		/* Special updates */
		
		public static const setGameContainer:String = "setGameContainer"; //Shortly used
		
		
		/* End of updates */
		
		public function Update() 
		{
			throw new Error();
		}
		
	}

}