package controller 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.interfaces.IInputController;
	import controller.interfaces.INotifier;
	import controller.interfaces.IProjectileController;
	import controller.interfaces.ISoundController;
	
	public class ControllerElements 
	{
		
		public function ControllerElements(binder:IBinder) 
		{
			var notifier:Notifier = new Notifier();
			
			binder.addBindable(notifier, INotifier);
			binder.addBindable(new Keys(notifier, binder), IInputController);
			binder.addBindable(new SoundController(notifier), ISoundController);
			binder.addBindable(new GameController(notifier), IGameController);
			binder.addBindable(new ProjectileController(notifier), IProjectileController);
		}
		
	}

}