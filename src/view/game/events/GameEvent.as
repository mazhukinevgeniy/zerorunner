package view.game.events 
{
	
	public class GameEvent 
	{
		public static const SHOW_OBSERVER:String = "showObserver";
		public static const SHOW_MENU:String = "showMenu";
		public static const SHOW_MAP:String = "showMap";
		public static const SHOW_WON:String = "showWon";
		public static const SHOW_LOST:String = "showLost";
		
		public function GameEvent() 
		{
			throw new Error("do not call");
		}
		
	}

}