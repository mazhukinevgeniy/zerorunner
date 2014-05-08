package view.sounds
{
	import model.interfaces.ISave;
	import starling.utils.AssetManager;
	
	internal class SoundManager extends SoundManagerBase
	{
		private var volume:Number;
		
		public function SoundManager(assets:AssetManager, save:ISave) 
		{
			super();
			
			this.volume = save.soundValue;
			
			this.initializeTracks(assets);
			
			if (save.soundMute)
			{
				this.muteAll(true);
			}
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