package view.game.renderer.utils 
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
	public class EffectTracker implements IGameFrameHandler, INewGameHandler, IShardObserver
	{
		private const STONE_BOOM_LENGTH:int = 6;
		private const STONE_BOOM_SPEED_FACTOR:int = 5;
		
		private var shards:Array;
		
		public function EffectTracker(binder:IBinder) 
		{
			
			binder.notifier.addObserver(this);
		}
		
		public function gameFrame(frame:int):void
		{
			for (var key:String in this.shards)
			{
				this.shards[key]--;
				
				if (this.shards[key] == 0)
					delete this.shards[key];
			}
		}
		
		public function newGame():void
		{
			this.shards = new Array();
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