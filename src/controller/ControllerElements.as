package controller 
{
	import binding.IBinder;
	import controller.interfaces.IInputController;
	
	public class ControllerElements 
	{
		
		public function ControllerElements(binder:IBinder) 
		{
			binder.addBindable(new InputController(binder), IInputController);
		}
		
	}

}