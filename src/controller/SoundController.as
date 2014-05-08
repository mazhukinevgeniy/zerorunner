package controller 
{
	import controller.interfaces.ISoundController;
	
	internal class SoundController implements ISoundController
	{
		private var notifier:Notifier;
		
		public function SoundController(notifier:Notifier) 
		{
			
			this.notifier = notifier;
		}
		
		
		public function setSoundMute(value:Boolean):void
		{
			this.notifier.setSoundMute(value);
		}
		
		public function setMusicMute(value:Boolean):void
		{
			this.notifier.setMusicMute(value);
		}
		
		public function setSoundValue(value:Number):void
		{
			//TODO: implement
		}
		
		public function setMusicValue(value:Number):void
		{
			//TODO:implement
		}
	}

}