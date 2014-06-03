package view.sounds 
{
	import binding.IBinder;
	import binding.IDependent;
	import events.GlobalEvent;
	import model.interfaces.ISave;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import structs.SoundMute;
	import structs.SoundVolume;
	
	public class Sounds implements IDependent
	{
		private var sounds:Vector.<SoundManagerBase>;
		
		private var save:ISave;
		
		public function Sounds(binder:IBinder) 
		{
			binder.requestBindingFor(this);
			
			binder.eventDispatcher.addEventListener(GlobalEvent.SET_SOUND_MUTE,
			                                        this.setSoundMute);
			binder.eventDispatcher.addEventListener(GlobalEvent.SET_SOUND_VOLUME,
			                                        this.setSoundVolume);
			
			super();
		}
		
		public function bindObjects(binder:IBinder):void//TODO: replace with an event
		{
			var assets:AssetManager = binder.assetManager;
			this.save = binder.save;
			
			this.sounds = new Vector.<SoundManagerBase>(View.NUMBER_OF_SOUND_TYPES, true);
			this.sounds[View.SOUND_MUSIC] = new MusicManager(assets, this.save);
			this.sounds[View.SOUND_EFFECT] = new SoundManager(assets, this.save);
		}
		
		private function setSoundMute(event:Event, mute:SoundMute):void
		{
			this.sounds[mute.type].muteAll(mute.value);
		}
		
		private function setSoundVolume(event:Event, volume:SoundVolume):void
		{
			this.sounds[volume.type].setGlobalVolume(volume.value);
			this.sounds[volume.type].muteAll(this.save.getSoundMute(volume.type));
			//the latter is done because otherwise mute settings would be ignored
			//TODO: fix that because hacks are not good
		}
		
	}

}