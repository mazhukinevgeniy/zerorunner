package model 
{
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import model.interfaces.ICollectible;
	import model.utils.normalize;
	
	internal class Collectibles implements ICollectible, INewGameHandler
	{
		private var collectibles:Array;
		
		public function Collectibles(binder:IBinder) 
		{
			
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			this.collectibles = new Array();
		}
		
		public function findCollectible(x:int, y:int):int
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.collectibles[x + y * Game.MAP_WIDTH] ? 
				Game.COLLECTIBLE_ONE : Game.COLLECTIBLE_NONE;
		}
	}

}