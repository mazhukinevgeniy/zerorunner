package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.IShardObserver;
	import model.projectiles.Projectile;
	
	
	internal class ShardTracker extends TrackerBase implements IShardObserver
	{
		
		public function ShardTracker(binder:IBinder) 
		{
			super(binder);
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			var duration:int = EffectRenderer.STONE_BOOM_LENGTH * 
			                   EffectRenderer.STONE_BOOM_SPEED_FACTOR;
			
			this.addEffect(duration, shard.cell);
		}
	}

}