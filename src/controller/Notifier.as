package controller 
{
	import controller.interfaces.INotifier;
	import controller.observers.game.IGameFrameHandler;
	import controller.observers.game.IGameStopHandler;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import controller.observers.ISoundObserver;
	import controller.observers.map.IMapFrameHandler;
	import controller.observers.map.IMapStatusObserver;
	
	internal class Notifier implements INotifier
	{
		private var _soundObservers:Vector.<ISoundObserver>;
		
		
		private var _newGame:Vector.<INewGameHandler>;
		private var _quitGame:Vector.<IQuitGameHandler>;
		private var _stopGame:Vector.<IGameStopHandler>;
		private var _gameFrame:Vector.<IGameFrameHandler>;
		
		private var _mapFrame:Vector.<IMapFrameHandler>;
		private var _mapVisibility:Vector.<IMapStatusObserver>;
		
		public function Notifier() 
		{
			this._soundObservers = new Vector.<ISoundObserver>();
			
			this._newGame = new Vector.<INewGameHandler>();
			this._quitGame = new Vector.<IQuitGameHandler>();
			this._stopGame = new Vector.<IGameStopHandler>();
			this._gameFrame = new Vector.<IGameFrameHandler>();
			
			this._mapFrame = new Vector.<IMapFrameHandler>();
			this._mapVisibility = new Vector.<IMapStatusObserver>();
		}
		
		
		public function addSoundObserver(observer:ISoundObserver):void
		{
			this._soundObservers.push(observer);
		}
		
		public function addGameStatusObserver(observer:*):void
		{
			if (observer is INewGameHandler)
				this._newGame.push(observer as INewGameHandler);
			
			if (observer is IQuitGameHandler)
				this._quitGame.push(observer as IQuitGameHandler);
			
			if (observer is IGameFrameHandler)
				this._gameFrame.push(observer as IGameFrameHandler);
			
			if (observer is IGameStopHandler)
				this._stopGame.push(observer as IGameStopHandler);
		}
		
		public function addMapStatusObserver(observer:*):void
		{
			if (observer is IMapFrameHandler)
				this._mapFrame.push(observer as IMapFrameHandler);
			
			if (observer is IMapStatusObserver)
				this._mapVisibility.push(observer as IMapStatusObserver);
		}
		
		
		internal function setSoundMute(value:Boolean):void
		{
			var length:int = this._soundObservers.length;
			for (var i:int = 0; i < length; i++)
			{
				this._soundObservers[i].setSoundMute(value);
			}
		}
		
		internal function setMusicMute(value:Boolean):void
		{
			var length:int = this._soundObservers.length;
			for (var i:int = 0; i < length; i++)
			{
				this._soundObservers[i].setMusicMute(value);
			}
		}
		
		internal function newGame():void
		{
			var length:int = this._newGame.length;
			for (var i:int = 0; i < length; i++)
			{
				this._newGame[i].newGame();
			}
		}
		
		internal function quitGame():void
		{
			var length:int = this._quitGame.length;
			for (var i:int = 0; i < length; i++)
			{
				this._quitGame[i].quitGame();
			}
		}
		
		internal function gameFrame(frame:int):void
		{
			var length:int = this._gameFrame.length;
			for (var i:int = 0; i < length; i++)
			{
				this._gameFrame[i].gameFrame(frame);
			}
		}
		
		internal function gameStopped(reason:int):void
		{
			var length:int = this._stopGame.length;
			for (var i:int = 0; i < length; i++)
			{
				this._stopGame[i].gameStopped(reason);
			}
		}
	}

}