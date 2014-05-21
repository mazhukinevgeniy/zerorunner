package model 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.ICollectibleObserver;
	import model.collectibles.Collectible;
	
	internal class VictoryDetector implements ICollectibleObserver
	{
		private var gameController:IGameController;
		
		public function VictoryDetector(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.gameController = binder.gameController;
		}
		
		public function setCollectibleFound(collectible:Collectible):void
		{
			if (collectible.type == Game.COLLECTIBLE_GOAL)
			{
				this.gameController.gameStopped(Game.ENDING_WON);
			}
		}
	}

}