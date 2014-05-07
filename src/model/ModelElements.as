package model 
{
	import binding.IBinder;
	
	public class ModelElements 
	{
		public var save:Save;
		
		public function ModelElements(binder:IBinder) 
		{
			this.save = new Save();
			
			
		}
		
	}

}