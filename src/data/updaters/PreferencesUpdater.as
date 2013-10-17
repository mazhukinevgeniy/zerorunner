package data.updaters 
{
	import flash.utils.Proxy;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class PreferencesUpdater 
	{
		private var save:Proxy;
		
		public function PreferencesUpdater(flow:IUpdateDispatcher, save:Proxy) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.toggleMute);
		}
		
		
		update function toggleMute():void
		{
			this.save["mute"] = !this.save["mute"];
		}
	}

}