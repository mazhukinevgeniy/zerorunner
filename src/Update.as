package  
{
	
	public class Update 
	{
		/* Input updates */
		
		public static const toggleMute:String = "toggleMute";
		
		public static const toggleMap:String = "toggleMap";
		
		public static const changeVolume:String = "changeVolume";
		
		public static const setVisibilityOfGameMenu:String = "setVisibilityOfGameMenu";
		
		public static const handleDeactivation:String = "handleDeactivation";
		
		/* Metagame updates */
		
		public static const newGame:String = "newGame"; //TODO: remove soon
		
		public static const gameFinished:String = "gameFinished";
		public static const quitGame:String = "quitGame"; //TODO: remove soon
		
		
		/* In-game updates */
		
		public static const dropShard:String = "dropShard";
		
		/* Time updates */
		
		public static const numberedFrame:String = "numberedFrame";
		public static const frameOfTheMapMode:String = "frameOfTheMapMode";
		
		
		/* End of updates */
		
		public function Update() 
		{
			throw new Error();
		}
		
		//TODO: replace everything
	}

}