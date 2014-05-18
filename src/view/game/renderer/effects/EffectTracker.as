package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IShardObserver;
	import model.projectiles.Projectile;
	import model.utils.normalize;
	
	
	/**
	 * Remembers how many frames should take some effect here or there
	 */
	internal class EffectTracker implements IGameFrameHandler, INewGameHandler, IShardObserver
	{
		private const STONE_BOOM_LENGTH:int = 6;
		private const STONE_BOOM_SPEED_FACTOR:int = 5;
		
		private var shards:Array;
		private var collection:Array;
		
		public function EffectTracker(binder:IBinder) 
		{
			
			binder.notifier.addObserver(this);
		}
		
		public function gameFrame(frame:int):void
		{
			this.reduceCounters(this.shards);
			this.reduceCounters(this.collection);
		}
		
		private function reduceCounters(arr:Array):void
		{
			for (var key:String in arr)
			{
				arr[key]--;
				
				if (arr[key] == 0)
					delete arr[key];
			}
		}
		
		public function newGame():void
		{
			this.shards = new Array();
			this.collection = new Array();
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			this.shards[shard.cell.x + Game.MAP_WIDTH * shard.cell.y] = 
				this.STONE_BOOM_LENGTH * this.STONE_BOOM_SPEED_FACTOR;
		}
		
		/**
		 * Returns the number of sprite we should use; if there's nothing to render, returns 7
		 * @param	x
		 * @param	y
		 * @return [1; 7]
		 */
		public function getShardAnimationFrame(x:int, y:int):int
		{
			var key:int = normalize(x) + normalize(y) * Game.MAP_WIDTH;
			
			return this.STONE_BOOM_LENGTH + 1 - int(this.shards[key] / this.STONE_BOOM_SPEED_FACTOR);
		}
	}

}