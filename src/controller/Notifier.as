package controller 
{
	import controller.interfaces.INotifier;
	import controller.observers.ISoundObserver;
	
	internal class Notifier implements INotifier
	{
		private var soundObservers:Vector.<ISoundObserver>;
		
		public function Notifier() 
		{
			
			this.soundObservers = new Vector.<ISoundObserver>();
		}
		
		
		public function addSoundObserver(observer:ISoundObserver):void
		{
			this.soundObservers.push(observer);
		}
		
		
		
		internal function setSoundMute(value:Boolean):void
		{
			var length:int = this.soundObservers.length;
			for (var i:int = 0; i < length; i++)
			{
				this.soundObservers[i].setSoundMute(value);
			}
		}
		
		internal function setMusicMute(value:Boolean):void
		{
			var length:int = this.soundObservers.length;
			for (var i:int = 0; i < length; i++)
			{
				this.soundObservers[i].setMusicMute(value);
			}
		}
	}

}