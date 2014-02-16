package  
{
	
	public class Update 
	{
		/* Input updates */
		
		public static const toggleMute:String = "toggleMute";
		public static const toggleWindow:String = "toggleWindow";
		
		public static const resetProgress:String = "resetProgress";
		
		public static const newInputPiece:String = "newInputPiece";
		public static const spacePressed:String = "spacePressed";
		
		
		/* Metagame updates */
		
		public static const newGame:String = "newGame";
		
		public static const restore:String = "restore";
		
		public static const gameFinished:String = "gameFinished";
		public static const quitGame:String = "quitGame";
		
		
		/* In-game updates */
		
		public static const setCenter:String = "setCenter";
		
		public static const puppetDies:String = "puppetDies"; //It was used for the categorising purposes
		
		public static const projectileLaunched:String = "projectileLaunched";
		public static const projectileLanded:String = "projectileLanded";
		
		public static const dropShard:String = "dropShard";
		
		
		/* Stat updates */
		
		public static const moveCenter:String = "moveCenter";
		
		public static const droidUnlocked:String = "droidUnlocked"; //It's not used, consider deleting
		
		
		/* Time updates */
		
		public static const numberedFrame:String = "numberedFrame";
		
		
		/* End of updates */
		
		public function Update() 
		{
			throw new Error();
		}
		
	}

}