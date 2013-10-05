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
		
		
		public function Sounds(flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.initializationSoundsManagers(assets);
			this.initializationUsingFlow(flow);
			
			super();
		}
		
		private function initializationSoundsManagers(assets:AssetManager):void
		{
			this.music = new MusicManager(assets);
			this.sound = new SoundManager(assets);
			
			this.music.playMusic();
		}
		
		private function initializationUsingFlow(flow:IUpdateDispatcher):void
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.keyUp);
			flow.addUpdateListener(Update.toggleMute);
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
				this.update::toggleMute();
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