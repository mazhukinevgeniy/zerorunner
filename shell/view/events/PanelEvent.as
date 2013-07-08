package view.events 
{
	import starling.events.Event;
	
	public class PanelEvent extends Event 
	{
		public static const BACK_TO_MENU:String = "PanelEvent.BackToMenu";
		public static const ROLL_OVER:String = "PanelEvent.RollOver";
		public static const ROLL_OUT:String = "PanelEvent.RollOut";
		
		public function PanelEvent(type:String) 
		{ 
			super(type, true);
			
		}
	}
	
}