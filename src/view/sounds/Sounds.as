package view.sounds 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.observers.ISoundObserver;
	import starling.utils.AssetManager;
	
	public class Sounds implements ISoundObserver, IDependent
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		
		public function Sounds(binder:IBinder) 
		{
			binder.requestBindingFor(this);
			
			super();
		}
		
		public function bindObjects(binder:IBinder):void
		{
			var assets:AssetManager = binder.assetManager;
			
			this.music = new MusicManager(assets);//TODO: pass mute settings here
			this.sound = new SoundManager(assets);
			
			this.music.playMusic();
		}
		
		public function setSoundMute(value:Boolean):void
		{
			this.sound.muteAll(value);
		}
		
		public function setMusicMute(value:Boolean):void
		{
			this.music.muteAll(value);
		}
		
		/*update function changeVolume(target:String, newValue:Number):void
		{
			if(target == Theme.MUSIC_SETTING)
				this.music.setGlobalVolume(newValue);
			else if (target == Theme.SOUND_SETTING)
				this.sound.setGlobalVolume(newValue);
		}*///TODO: must reimplement anyway
	}

}