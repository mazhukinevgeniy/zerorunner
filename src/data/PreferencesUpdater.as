package data 
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class PreferencesUpdater 
	{
		private var save:SharedObjectManager;
		
		public function PreferencesUpdater(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.toggleMute);
		}
		
		
		update function toggleMute():void
		{
			this.save.mute = !this.save.mute;
		}
	}

}