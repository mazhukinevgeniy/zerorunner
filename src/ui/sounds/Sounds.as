package ui.sounds 
{
	import flash.ui.Keyboard;
	import starling.utils.AssetManager;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Sounds extends SaveBase
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		private var flow:IUpdateDispatcher
		
		
		public function Sounds(flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.initializeSoundsManagers(assets);
			this.initializeUsingFlow(flow);
			
			super();
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
		
		override protected function checkLocalSave():void
		{
			if (this.localSave.data.sound == null)
			{
				this.localSave.data.sound = new Object();
				this.localSave.data.sound.muted = false;
			}
			
			if (this.localSave.data.sound.muted)
			{
				this.flow.dispatchUpdate(Update.toggleMute);
				this.localSave.data.sound.muted = true;
			}
		}
		
		update function toggleMute():void
		{
			this.music.toggleSound();
			this.sound.toggleSound();
			
			this.localSave.data.sound.muted = !this.localSave.data.sound.muted;
		}
		
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.M)
				this.update::toggleMute();
		}
	}

}