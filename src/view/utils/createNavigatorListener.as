package view.utils 
{
	import binding.IBinder;
	import controller.interfaces.IScreenController;
	import feathers.controls.ScreenNavigator;
	import starling.events.Event;
	
	public function createNavigatorListener(binder:IBinder):Function
	{
		const controller:IScreenController = binder.screenController;
		
		function listener(event:Event):void
		{
			var navigator:ScreenNavigator = event.target as ScreenNavigator;
			
			controller.screenActivated(navigator.activeScreenID);
		}
		
		return listener;
	}
	
}