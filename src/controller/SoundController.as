package controller 
{
	import controller.interfaces.ISoundController;
	import controller.observers.ISoundObserver;
	
	internal class SoundController implements ISoundController
	{
		private var notifier:Notifier;
		
		public function SoundController(notifier:Notifier) 
		{
			
			this.notifier = notifier;
		}
		
		public function setSoundMute(type:int, value:Boolean):void
		{
			this.notifier.call(ISoundObserver, "setSoundMute", type, value);
		}
		public function setSoundVolume(type:int, value:Number):void
		{
			this.notifier.call(ISoundObserver, "setSoundVolume", type, value);
		}
		
	}

}