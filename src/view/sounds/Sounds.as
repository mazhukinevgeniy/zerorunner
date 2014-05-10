package view.sounds 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.observers.ISoundObserver;
	import model.interfaces.ISave;
	import starling.utils.AssetManager;
	
	public class Sounds implements ISoundObserver, IDependent
	{
		private var music:MusicManager;
		private var sound:SoundManager;
		
		
		public function Sounds(binder:IBinder) 
		{
			binder.requestBindingFor(this);
			binder.notifier.addObserver(this);
			
			super();
		}
		
		public function bindObjects(binder:IBinder):void
		{
			var assets:AssetManager = binder.assetManager;
			var save:ISave = binder.save;
			
			this.music = new MusicManager(assets, save);
			this.sound = new SoundManager(assets, save);
			
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
		
		public function setSoundValue(value:Number):void
		{
			this.sound.setGlobalVolume(value);
		}//TODO: make it called
		
		public function setMusicValue(value:Number):void
		{
			this.music.setGlobalVolume(value);
		}
	}

}