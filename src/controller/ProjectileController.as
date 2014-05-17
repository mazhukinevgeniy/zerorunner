package controller 
{
	import controller.interfaces.IProjectileController;
	import controller.observers.IShardObserver;
	import model.projectiles.Projectile;
	
	public class ProjectileController implements IProjectileController
	{
		private var notifier:Notifier;
		
		public function ProjectileController(notifier:Notifier) 
		{
			
			this.notifier = notifier;
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			this.notifier.call(IShardObserver, "shardFellDown", shard);
		}
		
	}

}