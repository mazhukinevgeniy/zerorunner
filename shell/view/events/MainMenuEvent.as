package view.events 
{
	import starling.events.Event;
	
	
	public class MainMenuEvent extends Event 
	{
		public static const NEW_GAME:String = "MainMenuEvent.New game";
		public static const CLOSE:String = "MainMenuEvent.Close";
		
		
		public function MainMenuEvent(type:String) 
		{ 
			super(type, true);
			
		} 
		
	}
	
}