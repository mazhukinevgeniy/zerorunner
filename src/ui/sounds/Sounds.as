package ui.sounds 
{
	import data.viewers.PreferencesViewer;
	import flash.ui.Keyboard;
	import starling.utils.AssetManager;
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
				//TODO: do similar thing for the mutebutton
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
			this.flow.addUpdateListener(Update.keyUp);
			this.flow.addUpdateListener(Update.toggleMute);
		}
		
		update function toggleMute():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
		}
		
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.M)
				this.update::toggleMute();
		}
	}

}