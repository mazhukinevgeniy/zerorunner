package controller 
{
	
	public class ControllerElements 
	{
		private var controller:Controller;
		
		public function ControllerElements() 
		{
			
			this.controller = new Controller();
		}
		
		public function get notifier():INotifier
		{
			return this.controller;
		}
		
		public function get soundController():ISoundController
		{
			return this.controller;
		}
		
		public function get inputController():IInputController
		{
			return this.controller;
		}
	}

}