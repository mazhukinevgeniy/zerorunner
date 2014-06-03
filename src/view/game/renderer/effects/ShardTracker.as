package view.game.renderer.effects 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.projectiles.Projectile;
	import starling.events.Event;
	
	
	internal class ShardTracker extends TrackerBase
	{
		
		public function ShardTracker(binder:IBinder) 
		{
			super(binder);
			
			binder.eventDispatcher.addEventListener(GlobalEvent.PROJECTILE_FELL, this.shardFellDown);
		}
		
		public function shardFellDown(event:Event, shard:Projectile):void
		{
			if (shard.type == Game.PROJECTILE_SHARD)
			{			
				var duration:int = EffectRenderer.STONE_BOOM_LENGTH * 
								   EffectRenderer.STONE_BOOM_SPEED_FACTOR;
				
				this.addEffect(duration, shard.cell);
			}
		}
	}

}