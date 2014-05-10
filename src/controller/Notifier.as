package controller 
{
	import controller.interfaces.INotifier;
	import controller.observers.game.IGameFrameHandler;
	import controller.observers.game.IGameMenuRelated;
	import controller.observers.game.IGameStopHandler;
	import controller.observers.game.IInputObserver;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import controller.observers.ISoundObserver;
	import controller.observers.map.IMapFrameHandler;
	import controller.observers.map.IMapStatusObserver;
	import controller.observers.projectiles.IShardObserver;
	import model.metric.DCellXY;
	import model.projectiles.Projectile;
	
	internal class Notifier implements INotifier
	{
		private var _soundObservers:Vector.<ISoundObserver>;
		
		
		private var _newGame:Vector.<INewGameHandler>;
		private var _quitGame:Vector.<IQuitGameHandler>;
		private var _stopGame:Vector.<IGameStopHandler>;
		private var _gameFrame:Vector.<IGameFrameHandler>;
		private var _gameMenu:Vector.<IGameMenuRelated>;
		private var _input:Vector.<IInputObserver>;
		
		private var _mapFrame:Vector.<IMapFrameHandler>;
		private var _mapVisibility:Vector.<IMapStatusObserver>;
		
		private var _shardIncoming:Vector.<IShardObserver>;
		
		public function Notifier() 
		{
			this._soundObservers = new Vector.<ISoundObserver>();
			
			this._newGame = new Vector.<INewGameHandler>();
			this._quitGame = new Vector.<IQuitGameHandler>();
			this._stopGame = new Vector.<IGameStopHandler>();
			this._gameFrame = new Vector.<IGameFrameHandler>();
			this._gameMenu = new Vector.<IGameMenuRelated>();
			this._input = new Vector.<IInputObserver>();
			
			this._mapFrame = new Vector.<IMapFrameHandler>();
			this._mapVisibility = new Vector.<IMapStatusObserver>();
			
			this._shardIncoming = new Vector.<IShardObserver>();
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
			
			if (observer is IGameMenuRelated)
				this._gameMenu.push(observer as IGameMenuRelated);
			
			if (observer is IInputObserver)
				this._input.push(observer as IInputObserver);
		}
		
		public function addMapStatusObserver(observer:*):void
		{
			if (observer is IMapFrameHandler)
				this._mapFrame.push(observer as IMapFrameHandler);
			
			if (observer is IMapStatusObserver)
				this._mapVisibility.push(observer as IMapStatusObserver);
		}
		
		public function addProjectileObserver(observer:*):void
		{
			if (observer is IShardObserver)
				this._shardIncoming.push(observer as IShardObserver);
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
		
		internal function mapFrame():void
		{
			var length:int = this._mapFrame.length;
			for (var i:int = 0; i < length; i++)
			{
				this._mapFrame[i].mapFrame();
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
		
		internal function setVisibilityOfMenu(visible:Boolean):void
		{
			var length:int = this._gameMenu.length;
			for (var i:int = 0; i < length; i++)
			{
				this._gameMenu[i].setVisibilityOfMenu(visible);
			}
		}
		
		internal function shardFell(shard:Projectile):void
		{
			var length:int = this._shardIncoming.length;
			for (var i:int = 0; i < length; i++)
			{
				this._shardIncoming[i].shardFellDown(shard);
			}
		}
		
		internal function newInputPiece(isOn:Boolean, change:DCellXY):void
		{
			var length:int = this._input.length;
			for (var i:int = 0; i < length; i++)
			{
				this._input[i].newInputPiece(isOn, change);
			}
		}
		
		internal function actionRequested(action:int):void
		{
			var length:int = this._input.length;
			for (var i:int = 0; i < length; i++)
			{
				this._input[i].actionRequested(action);
			}
		}
		
		internal function setVisibilityOfMap(visible:Boolean):void
		{
			var length:int = this._mapVisibility.length;
			for (var i:int = 0; i < length; i++)
			{
				this._mapVisibility[i].setVisibilityOfMap(visible);
			}
		}
		
		
	}

}