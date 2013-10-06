package  
{
	
	public class Update 
	{
		/* Input updates */
		
		public static const keyUp:String = "keyUp";
		
		public static const discardClicks:String = "discardClicks";
		
		
		/* Metagame updates */
		
		public static const newGame:String = "newGame";
		
		public static const prerestore:String = "prerestore";
		public static const restore:String = "restore";
		
		public static const gameStopped:String = "gameStopped";
		public static const quitGame:String = "quitGame";
		
		public static const tellRoundLost:String = "tellRoundLost";
		public static const tellRoundWon:String = "tellRoundWon";
		public static const tellGameWon:String = "tellGameWon";
		
		
		/* In-game updates */
		
		public static const smallBeaconTurnedOn:String = "smallBeaconTurnedOn";
		public static const technicUnlocked:String = "technicUnlocked";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		
		/* Time updates */
		
		public static const freeFrame:String = "freeFrame";
		//TODO: rename the freeFrame, as it's not really free
		
		public static const redraw:String = "redraw";
		public static const tick:String = "tick";
		
		
		/* Shell updates */
		
		public static const toggleMute:String = "toggleMute";
		public static const toggleWindow:String = "toggleWindow";
		
		public static const resetProgress:String = "resetProgress";
		
		
		/* Special updates */
		
		public static const setGameContainer:String = "setGameContainer";
		public static const addToTheHUD:String = "addToTheHUD";
		
		
		
		/* End of updates */
		
		public function Update() 
		{
			throw new Error();
		}
		
	}

}