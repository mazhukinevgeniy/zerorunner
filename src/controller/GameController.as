package controller 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.IGameController;
	import controller.observers.ICollectibleObserver;
	import controller.observers.IGameFrameHandler;
	import controller.observers.IGameMapObserver;
	import controller.observers.IGameMenuObserver;
	import controller.observers.IGameObserver;
	import controller.observers.IGameStopHandler;
	import controller.observers.IMapFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.collectibles.Collectible;
	import model.interfaces.IStatus;
	
	internal class GameController implements IGameController, IDependent
	{
		private var notifier:Notifier;
		
		private var gameStatus:IStatus;
		
		public function GameController(notifier:Notifier, binder:IBinder) 
		{
			this.notifier = notifier;
			
			binder.requestBindingFor(this);
		}
		
		public function bindObjects(binder:IBinder):void
		{
			this.gameStatus = binder.gameStatus;
		}
		
		
		public function newGame():void
		{
			if (!this.gameStatus.isGameOn())
				this.notifier.call(INewGameHandler, "newGame");
			else
				throw new Error("can't start game twice, something is very wrong");
		}
		
		public function quitGame():void
		{
			if (this.gameStatus.isGameOn())
				this.notifier.call(IQuitGameHandler, "quitGame");
			else
				throw new Error("can't quit game twice, something is very wrong");
		}
		
		public function gameFrame(frame:int):void
		{
			this.notifier.call(IGameFrameHandler, "gameFrame", frame);
		}
		
		public function mapFrame():void
		{
			this.notifier.call(IMapFrameHandler, "mapFrame");
		}
		
		public function gameStopped(reason:int):void
		{
			this.notifier.call(IGameStopHandler, "gameStopped", reason);
		}
		
		public function showGameMenu():void
		{
			this.notifier.call(IGameMenuObserver, "showGameMenu");
		}
		
		public function showGameMap():void
		{
			this.notifier.call(IGameMapObserver, "showGameMap");
		}
		
		public function showGame():void
		{
			this.notifier.call(IGameObserver, "showGame");
		}
		
		public function setCollectibleFound(collectible:Collectible):void
		{
			this.notifier.call(ICollectibleObserver, "setCollectibleFound", collectible);
		}
	}

}