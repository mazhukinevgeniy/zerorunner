package model 
{
	import binding.IBinder;
	import model.interfaces.IFuel;
	import model.interfaces.IProjectiles;
	import model.interfaces.IPuppets;
	import model.interfaces.IStatus;
	import model.items.Items;
	import model.projectiles.Projectiles;
	import model.status.StatusReporter;
	
	public class ModelElements 
	{
		
		public function ModelElements(binder:IBinder) 
		{
			new Save(binder);
			
			var status:StatusReporter = new StatusReporter(binder);
			
			binder.addBindable(status, IStatus);
			binder.addBindable(new FuelTracker(binder), IFuel);
			binder.addBindable(new Items(binder, status), IPuppets);
			binder.addBindable(new Projectiles(binder), IProjectiles);
		}
		
	}

}