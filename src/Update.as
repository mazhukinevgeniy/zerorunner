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
		
		public static const quitGame:String = "quitGame";
		
		public static const tellRoundLost:String = "tellRoundLost";
		public static const tellRoundWon:String = "tellRoundWon";
		public static const tellGameWon:String = "tellGameWon";
		//TODO: it feels like methods, so, huh, implement it this way
		
		
		/* In-game updates */
		
		public static const smallBeaconTurnedOn:String = "smallBeaconTurnedOn";
		public static const technicUnlocked:String = "technicUnlocked";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		
		/* Time updates */
		
		public static const numberedFrame:String = "numberedFrame";
		
		
		/* Shell updates */
		
		public static const toggleMute:String = "toggleMute";
		public static const toggleWindow:String = "toggleWindow";
		
		public static const resetProgress:String = "resetProgress";
		
		
		/* End of updates */
		
		public function Update() 
		{
			throw new Error();
		}
		
	}

}