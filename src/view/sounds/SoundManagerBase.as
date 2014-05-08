package view.sounds
{
	//first author: Francesco Maisto
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import starling.core.Starling;

	internal class SoundManagerBase 
	{
		
		public static const MAX_VOLUME:Number = 1.0;
		public static const MIN_VOLUME:Number = 0;

		private static var _instance:SoundManagerBase;
		protected var _isMuted:Boolean = false;		// When true, every change in volume for ALL sounds, is ignored

		private var sounds:Dictionary;				// contains all the sounds registered with the sound manager
		private var currPlayingSounds:Dictionary;	// contains all the sounds of the sound manager that are currently playing

		public function SoundManagerBase() {
			
			sounds = new Dictionary();
			currPlayingSounds = new Dictionary();
		}
		
		public static function getInstance():SoundManagerBase {
			
			if (!_instance)
				_instance = new SoundManagerBase();
				
			return _instance;
		}
		
		protected function destroy():void {
			
			sounds = null;
			currPlayingSounds = null;
		}
			
		/** Store sounds in the sound dictionary */
		protected function addSound(id:String, sound:Sound):void {
			
				sounds[id] = sound;
		}
		
		/** Remove sounds from the sound manager */
		protected function removeSound(id:String):void {
			if (soundIsAdded(id)) {
				delete sounds[id];
				
				if (soundIsPlaying(id))
					delete currPlayingSounds[id];
			}
			else {
				throw Error("The sound you are trying to remove is not in the sound manager");
			}
		}
		
		/** Check if a sound is in the sound manager */
		public function soundIsAdded(id:String):Boolean {
			return Boolean(sounds[id]);
		}
		
		/** Check if a sound is playing */
		public function soundIsPlaying(id:String):Boolean {
			for (var currID:String in currPlayingSounds) {
				if ( currID == id )
					return true;
			}	
			return false;
		}
		
		/** Play a sound */
		protected function playSound(id:String, volume:Number = SoundManagerBase.MAX_VOLUME, repetitions:int = 1, panning:Number = 0):void {			
			
			if (soundIsAdded(id))
			{
				trace( "SoundManagerBase.playSound > id : " + id + ", volume : " + volume + ", repetitions : " + repetitions + ", panning : " + panning );
				var soundObject:Sound = sounds[id];
			
				var channel:SoundChannel = new SoundChannel();
				
				channel = soundObject.play(0, repetitions);
				
				if (!channel)
					return;
				
				// if the sound manager is muted, set the sound's volume to zero
				var v:Number = (_isMuted)? 0 : volume;
				var s:SoundTransform = new SoundTransform(v, panning);
				channel.soundTransform = s;

				currPlayingSounds[id] = { channel:channel, sound:soundObject, volume:volume };
			}
			else
			{
				throw Error("The sound you are trying to play is not in the Sound Manager. Try adding it to the Sound Manager first.");
			}
		}
		
		/** Stop a sound and remove it from the dictionary of the sounds that are currently playing */
		protected function stopSound(id:String):void {			
			if (soundIsPlaying(id))
			{
				SoundChannel(currPlayingSounds[id].channel).stop();
				delete currPlayingSounds[id];
			}
			else
			{
				// throw Error("The sound you are trying to stop ( " + id + " ) is not currently playing");
			}
		}	
		
		/** Set a sound's volume */
		protected function setVolume(id:String, volume:Number):void {			
			if (soundIsPlaying(id))
			{
				var s:SoundTransform = new SoundTransform(volume);
				SoundChannel(currPlayingSounds[id].channel).soundTransform = s;
				currPlayingSounds[id].volume = volume;
			}
			else
			{
				throw Error("This sound (id = " + id + " ) is not currently playing");
			}
		}
		
		/** Tween a sound's volume */
		protected function tweenVolume(id:String, volume:Number = SoundManagerBase.MIN_VOLUME, tweenDuration:Number = 2):void {
			if (soundIsPlaying(id))
			{
				var s:SoundTransform = new SoundTransform();			
				
				Starling.juggler.tween(currPlayingSounds[id], tweenDuration, {
				   volume: volume,
				   onUpdate: function():void {
							if (!_isMuted)
							{
								s.volume = currPlayingSounds[id].volume;
								SoundChannel(currPlayingSounds[id].channel).soundTransform = s;
							}
						}
				});
			}
			else
			{
				throw Error("This sound (id = " + id + " ) is not currently playing");
			}
		}
		
		/** Cross fade two sounds. N.B. The sounds that fades out must be already playing */
		protected function crossFade(fadeOutId:String, fadeInId:String, tweenDuration:Number = 2, fadeInVolume:Number = 1, fadeInRepetitions:int = 1):void {			
			
			// if the fade-in sound is not already playing, start playing it
			if (!soundIsPlaying(fadeInId))
				playSound(fadeInId, SoundManagerBase.MIN_VOLUME, fadeInRepetitions);
			
			tweenVolume (fadeOutId, SoundManagerBase.MIN_VOLUME, tweenDuration);
			tweenVolume (fadeInId, fadeInVolume, tweenDuration);
			
			// stop the fade-out sound when its volume reaches zero
			Starling.juggler.delayCall(stopSound, tweenDuration, fadeOutId);
		}
		
		/** Sets a new volume for all the sounds currently playing 
		*  @param volume the new volume value 
		*/
		public function setGlobalVolume(volume:Number):void {
			var s:SoundTransform;
			for (var currID:String in currPlayingSounds) {
				s = new SoundTransform(volume);
				SoundChannel(currPlayingSounds[currID].channel).soundTransform = s;
				currPlayingSounds[currID].volume = volume;
			}
		}
		
		/** Mute all sounds currently playing.
		*  @param mute a Boolean dictating whether all the sounds in the sound manager should be silenced or restored to their original volume. 
		*/ 
		public function muteAll(mute:Boolean = true):void {
			var s:SoundTransform;
			for (var currID:String in currPlayingSounds) 
			{
				s = new SoundTransform(mute ? SoundManagerBase.MIN_VOLUME : currPlayingSounds[currID].volume);
				SoundChannel(currPlayingSounds[currID].channel).soundTransform = s;
			}
			_isMuted = mute;			
		}
		
		protected function getSoundChannel(id:String):SoundChannel {			
			if (soundIsPlaying(id))
				return SoundChannel(currPlayingSounds[id].channel);
				
			throw Error("You are trying to get a non-existent soundChannel. Play it first in order to assign a channel.");
		}
		
		protected function getSoundTransform(id:String):SoundTransform {			
			if (soundIsPlaying(id))
				return SoundChannel(currPlayingSounds[id].channel).soundTransform;

			throw Error("You are trying to get a non-existent soundTransform. Play it first in order to assign a transform.");
		}
		
		protected function getSoundVolume(id:String):Number {			
			if (soundIsPlaying(id))
				return currPlayingSounds[id].volume;

			throw Error("You are trying to get a non-existent volume. Play it first in order to assign a volume.");
		}		
	}
}