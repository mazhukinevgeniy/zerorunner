package view.game.renderer.effects 
{
	import binding.IBinder;
	import controller.observers.IShardObserver;
	import model.projectiles.Projectile;
	import utils.normalize;
	import view.game.renderer.structs.Effect;
	
	
	internal class ShardTracker extends TrackerBase implements IShardObserver
	{
		
		public function ShardTracker(binder:IBinder) 
		{
			super(binder);
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			var effect:Effect = new Effect();
			
			effect.duration = EffectRenderer.STONE_BOOM_LENGTH * 
			                  EffectRenderer.STONE_BOOM_SPEED_FACTOR;
			
			this.addEffect(effect, shard.cell);
		}
	}

}