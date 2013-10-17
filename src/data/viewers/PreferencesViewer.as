package data.viewers 
{
	import flash.utils.Proxy;
	
	public class PreferencesViewer
	{
		private var save:Proxy;
		
		public function PreferencesViewer(save:Proxy) 
		{
			this.save = save;
		}
		
		public function get mute():Boolean
		{
			return this.save["mute"];
		}
	}

}