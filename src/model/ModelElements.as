package model 
{
	import binding.IBinder;
	import model.input.InputTeller;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.interfaces.IProjectiles;
	import model.interfaces.IPuppets;
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
			binder.addBindable(new Items(binder, status), IPuppets);
			binder.addBindable(new Projectiles(binder), IProjectiles);
			
			binder.addBindable(new Exploration(binder), IExploration);
			
			new Time(binder);
		}
		
	}

}