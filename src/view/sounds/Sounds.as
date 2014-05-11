package view.sounds 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.observers.ISoundObserver;
	import model.interfaces.ISave;
	import starling.utils.AssetManager;
	
	public class Sounds implements ISoundObserver, IDependent
	{
		private var sounds:Vector.<SoundManagerBase>;
		
		private var save:ISave;
		
		public function Sounds(binder:IBinder) 
		{
			binder.requestBindingFor(this);
			binder.notifier.addObserver(this);
			
			super();
		}
		
		public function bindObjects(binder:IBinder):void
		{
			var assets:AssetManager = binder.assetManager;
			this.save = binder.save;
			
			this.sounds = new Vector.<SoundManagerBase>(View.NUMBER_OF_SOUND_TYPES, true);
			this.sounds[View.SOUND_MUSIC] = new MusicManager(assets, this.save);
			this.sounds[View.SOUND_EFFECT] = new SoundManager(assets, this.save);
		}
		
		public function setSoundMute(type:int, value:Boolean):void
		{
			this.sounds[type].muteAll(value);
		}
		
		public function setSoundVolume(type:int, value:Number):void
		{
			this.sounds[type].setGlobalVolume(value);
			this.sounds[type].muteAll(this.save.getSoundMute(type));
			//the latter is done because otherwise mute settings would be ignored
		}
		
	}

}