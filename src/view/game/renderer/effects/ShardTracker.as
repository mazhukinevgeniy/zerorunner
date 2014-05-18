package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.IShardObserver;
	import model.projectiles.Projectile;
	import model.utils.normalize;
	import view.game.renderer.structs.Effect;
	
	
	internal class ShardTracker extends TrackerBase implements IShardObserver
	{
		
		public function ShardTracker(binder:IBinder) 
		{
			
			binder.notifier.addObserver(this);
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			var effect:Effect = new Effect();
			
			effect.duration = EffectRenderer.STONE_BOOM_LENGTH * 
			                  EffectRenderer.STONE_BOOM_SPEED_FACTOR;
			
			var x:int = shard.cell.x;
			var y:int = shard.cell.y;
			
			this.tracked[x + y * Game.MAP_WIDTH] = effect;
		}
	}

}