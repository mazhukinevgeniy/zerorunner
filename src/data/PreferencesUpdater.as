package data 
{
	
	internal class PreferencesUpdater 
	{
		
		public function PreferencesUpdater() 
		{
			
		}
		
		
		update function toggleMute():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
			
			this.localSave.data.sound.muted = !this.localSave.data.sound.muted;
		}
	}

}