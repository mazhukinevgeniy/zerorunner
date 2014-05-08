package controller 
{
	import controller.interfaces.IProjectileController;
	import model.projectiles.Projectile;
	
	public class ProjectileController implements IProjectileController
	{
		private var notifier:Notifier;
		
		public function ProjectileController(notifier:Notifier) 
		{
			
			this.notifier = notifier;
		}
		
		public function shardFell(shard:Projectile):void
		{
			this.notifier.shardFell(shard);
		}
		
		public function denyProjectile(projectile:Projectile):void
		{
			this.notifier.denyProjectile(projectile);
		}
	}

}