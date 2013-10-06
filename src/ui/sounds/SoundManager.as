package ui.sounds
{
	import starling.utils.AssetManager;
	
	internal class SoundManager extends SoundManagerBase
	{
		private var volume:Number;
		
		public function SoundManager(assets:AssetManager, newVolume:Number = 1.0) 
		{
			super();
			
			this.volume = newVolume;
			
			this.initializeTracks(assets);
		}
		
		private function initializeTracks(assets:AssetManager):void
		{
			this.addSound("1", assets.getSound("Paging"));
		}
		
		public function play(id:String):void
		{
			this.playSound(id, this.volume);
		}
		
	}

}