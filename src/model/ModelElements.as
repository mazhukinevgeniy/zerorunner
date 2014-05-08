package model 
{
	import binding.IBinder;
	import model.interfaces.IFuel;
	import model.interfaces.IStatus;
	import model.status.StatusReporter;
	
	public class ModelElements 
	{
		
		public function ModelElements(binder:IBinder) 
		{
			new Save(binder);
			
			binder.addBindable(new StatusReporter(binder), IStatus);
			binder.addBindable(new FuelTracker(binder), IFuel);
		}
		
	}

}