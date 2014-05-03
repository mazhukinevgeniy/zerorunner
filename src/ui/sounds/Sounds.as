package ui.sounds 
{
	import data.Preferences;
	import game.GameElements;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Sounds
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		private var flow:IUpdateDispatcher
		
		
		public function Sounds(elements:GameElements) 
		{
			this.initializeSoundsManagers(elements.assets);
			this.initializeUsingFlow(elements.flow);
			
			super();
			
			if (elements.preferences.mute)
			{
				this.update::toggleMute();
			}
		}
		
		private function initializeSoundsManagers(assets:AssetManager):void
		{
			this.music = new MusicManager(assets);
			this.sound = new SoundManager(assets);
			
			this.music.playMusic();
		}
		
		private function initializeUsingFlow(flow:IUpdateDispatcher):void
		{
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.toggleMute);
		}
		
		update function toggleMute():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
		}
	}

}