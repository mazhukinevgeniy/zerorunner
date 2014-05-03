package data 
{
	import flash.net.SharedObject;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Preferences
	{
		private var so:SharedObject;
		
		public function Preferences(flow:IUpdateDispatcher) 
		{
			const PROJECT_NAME:String = "zeroRunner";
			this.so = SharedObject.getLocal(PROJECT_NAME);
			
			if (!this.so.data.hasOwnProperty("mute"))
				this.so.data.mute = false;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.toggleMute);
		}
		
		public function get mute():Boolean
		{
			return this.so.data.mute;
		}
		
		
		update function toggleMute():void
		{
			this.so.data.mute = !this.so.data.mute;
		}
	}

}