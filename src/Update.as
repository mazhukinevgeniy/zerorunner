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
		
		public static const gameFinished:String = "gameFinished";
		public static const quitGame:String = "quitGame";
		
		
		/* In-game updates */
		
		public static const smallBeaconTurnedOn:String = "smallBeaconTurnedOn";
		public static const droidUnlocked:String = "droidUnlocked";
		
		public static const moveCenter:String = "moveCenter";
		public static const setCenter:String = "setCenter";
		
		public static const puppetDies:String = "puppetDies";
		
		public static const projectileLaunched:String = "projectileLaunched";
		public static const projectileLanded:String = "projectileLanded";
		
		public static const dropShard:String = "dropShard";
		
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