package ui.sounds 
{
	import data.viewers.PreferencesViewer;
	import starling.utils.AssetManager;
	import ui.themes.Theme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Sounds
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		private var flow:IUpdateDispatcher
		
		
		public function Sounds(flow:IUpdateDispatcher, assets:AssetManager, config:PreferencesViewer) 
		{
			this.initializeSoundsManagers(assets);
			this.initializeUsingFlow(flow);
			
			super();
			
			if (config.mute)
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
			this.flow.addUpdateListener(Update.changeVolume);
		}
		
		update function toggleMute():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
		}
		
		update function changeVolume(target:String, newValue:Number):void
		{
			if(target == Theme.MUSIC_SETTING)
				this.music.setGlobalVolume(newValue);
			else if (target == Theme.SOUND_SETTING)
				this.sound.setGlobalVolume(newValue);
		}
	}

}