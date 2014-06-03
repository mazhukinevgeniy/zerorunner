package view.utils 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.ScreenNavigator;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public function createNavigatorListener(binder:IBinder):Function
	{
		const dispatcher:EventDispatcher = binder.eventDispatcher;
		
		function listener(event:Event):void
		{
			var navigator:ScreenNavigator = event.target as ScreenNavigator;
			
			dispatcher.dispatchEventWith(GlobalEvent.SCREEN_ACTIVATED,
			                             false,
										 navigator.activeScreenID);
		}
		
		return listener;
	}
	
}