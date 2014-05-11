package controller 
{
	import controller.interfaces.IScreenController;
	
	internal class ScreenController implements IScreenController
	{
		private var notifier:Notifier;
		
		public function ScreenController(notifier:Notifier) 
		{
			this.notifier = notifier;
		}
		
		public function screenActivated(name:String):void
		{
			this.notifier.screenActivated(name);
		}
	}

}