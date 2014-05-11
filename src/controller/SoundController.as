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
		
		public function setSoundMute(type:int, value:Boolean):void
		{
			this.notifier.setSoundMute(type, value);
		}
		public function setSoundValue(type:int, value:Number):void
		{
			this.notifier.setSoundValue(type, value);
		}
		
	}

}