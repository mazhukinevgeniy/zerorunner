package model 
{
	import binding.IBinder;
	import model.collectibles.Collectibles;
	import model.input.InputTeller;
	import model.interfaces.ICollectibles;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.interfaces.IProjectiles;
	import model.interfaces.ISave;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import model.items.Items;
	import model.projectiles.Projectiles;
	import model.status.StatusReporter;
	
	public class ModelElements 
	{
		
		public function ModelElements(binder:IBinder) 
		{
			binder.addBindable(new Save(binder), ISave);
			
			var status:StatusReporter = new StatusReporter(binder);
			binder.addBindable(status, IStatus);
			
			binder.addBindable(new InputTeller(binder), IInput);
			
			binder.addBindable(new Scene(binder), IScene);
			
			var items:Items = new Items(binder, status);
			
			binder.addBindable(new Projectiles(binder, items), IProjectiles);
			binder.addBindable(new Collectibles(binder), ICollectibles);
			
			binder.addBindable(new Exploration(binder), IExploration);
			
			new Time(binder);
			new VictoryDetector(binder);
		}
		
	}

}