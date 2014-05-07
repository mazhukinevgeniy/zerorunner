package view.windows.credits 
{
	import starling.display.Quad;
	import starling.events.Event;
	import ui.navigation.Navigation;
	import ui.windows.Window;
	import utils.updates.IUpdateDispatcher;
	
	public class CreditsWindow  extends Window
	{	
		private var flow:IUpdateDispatcher;
		
		public function CreditsWindow(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
		}

	}

}