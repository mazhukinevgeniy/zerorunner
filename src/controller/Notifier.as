package controller 
{
	import controller.interfaces.INotifier;
	import controller.observers.IGameStatusObserver;
	import controller.observers.ISoundObserver;
	
	internal class Notifier implements INotifier
	{
		private var soundObservers:Vector.<ISoundObserver>;
		private var gameStatusObservers:Vector.<IGameStatusObserver>;
		
		public function Notifier() 
		{
			
			this.soundObservers = new Vector.<ISoundObserver>();
			this.gameStatusObservers = new Vector.<IGameStatusObserver>();
		}
		
		
		public function addSoundObserver(observer:ISoundObserver):void
		{
			this.soundObservers.push(observer);
		}
		public function addGameStatusObserver(observer:IGameStatusObserver):void
		{
			this.gameStatusObservers.push(observer);
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
		
		internal function newGame():void
		{
			var length:int = this.gameStatusObservers.length;
			for (var i:int = 0; i < length; i++)
			{
				this.gameStatusObservers[i].newGame();
			}
		}
		
		internal function quitGame():void
		{
			var length:int = this.gameStatusObservers.length;
			for (var i:int = 0; i < length; i++)
			{
				this.gameStatusObservers[i].quitGame();
			}
		}
	}

}