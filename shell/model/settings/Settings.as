package model.settings 
{
	import model.SaveBase;
	
	public class Settings extends SaveBase implements ISettings
	{
		
		public function Settings() 
		{
			super();
			
			this.reinitialize();
		}
		
		private function reinitialize():void
		{
			if (this.localSave.data.muteSettings == null)
				this.localSave.data.muteSettings = false;
		}
		
		public function set mute(newValue:Boolean):void
		{
			this.localSave.data.muteSettings = newValue;
		}
		
		public function get mute():Boolean
		{
			return this.localSave.data.muteSettings;
		}
		
		public function toggleMuteOptions():void
		{
			this.mute = !this.mute;
		}
	}

}