package ui.sounds 
{
	import flash.events.Event;
	import starling.utils.AssetManager;
	
	internal class MusicManager extends SoundManagerBase
	{
		private var currentTrack:int;
		private var volume:Number;
		
		private var countTrack:int = 0;
		
		function MusicManager(assets:AssetManager, newVolume:Number = 1.0) 
		{
			super();
			
			this.volume = newVolume;
			
			this.initializationTracks();
			
			this.currentTrack = this.nextTrack((int)(Math.random() * 100));
		}
		
		private function initializationTracks(assets:AssetManager):void
		{
			this.addSound("1", assets.getSound("Veloma"));
			this.countTrack++;
		}
		
		private function nextTrack(nowTrack:int):int
		{
			return (nowTrack % this.countTrack) + 1;
		}
 
		public function playMusic():void
		{
			this.currentTrack = this.nextTrack(this.currentTrack);
			this.playSound((String)(this.currentTrack), this.volume);
			
			this.getSoundChannel((String)(this.currentTrack)).addEventListener(Event.SOUND_COMPLETE, this.trackComplete);
		}
		
		private function trackComplete(event:Event):void
		{
			this.playMusic();
		}
		
	}
	

}