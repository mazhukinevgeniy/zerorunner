package controller 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.IGameController;
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
				this.notifier.newGame();
			else
				throw new Error("can't start game twice, something is very wrong");
		}
		
		public function quitGame():void
		{
			if (this.gameStatus.isGameOn())
				this.notifier.quitGame();
			else
				throw new Error("can't quit game twice, something is very wrong");
		}
		
		public function gameFrame(frame:int):void
		{
			this.notifier.gameFrame(frame);
		}
		
		public function mapFrame():void
		{
			this.notifier.mapFrame();
		}
		
		public function gameStopped(reason:int):void
		{
			this.notifier.gameStopped(reason);
		}
		
		public function showGameMenu():void
		{
			this.notifier.showGameMenu();
		}
		
		public function showGameMap():void
		{
			this.notifier.showGameMap();
		}
		
		public function showGame():void
		{
			this.notifier.showGame();
		}
	}

}