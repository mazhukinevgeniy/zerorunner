package controller 
{
	import controller.interfaces.IGameController;
	
	internal class GameController implements IGameController
	{
		private var notifier:Notifier;
		
		public function GameController(notifier:Notifier) 
		{
			this.notifier = notifier;
		}
		
		public function newGame():void
		{
			//TODO: might add check for isGameGoing() so we're safer
			this.notifier.newGame();
		}
		
		public function quitGame():void
		{
			this.notifier.quitGame();
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
		
		public function setVisibilityOfMenu(visible:Boolean):void
		{
			this.notifier.setVisibilityOfMenu(visible);
		}
	}

}