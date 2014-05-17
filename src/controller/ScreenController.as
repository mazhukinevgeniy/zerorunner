package controller 
{
	import controller.interfaces.IScreenController;
	import controller.observers.IScreenObserver;
	
	internal class ScreenController implements IScreenController
	{
		private var notifier:Notifier;
		
		public function ScreenController(notifier:Notifier) 
		{
			this.notifier = notifier;
		}
		
		public function screenActivated(name:String):void
		{
			this.notifier.call(IScreenObserver, "screenActivated", name);
		}
	}

}