package view.events 
{
	import starling.events.Event;
	
	public class NavigationEvent extends Event 
	{
		
		public function NavigationEvent(type:String) 
		{ 
			super(type, true);
		}		
	}
	
}