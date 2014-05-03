package game.projectiles 
{
	
	public class ProjectileController 
	{
		private var projs:Projectiles;
		
		public function ProjectileController() 
		{
			
		}
		
		public function addSubscriber(projectiles:Projectiles):void
		{
			if (this.projs)
				throw new Error("something went wrong");
			
			this.projs = projectiles;
		}
		
		
		
		public function denyProjectile(projectile:Projectile):void
		{
			this.projs.denyProjectile(projectile);
		}
		
		public function launchProjectile(projectile:Projectile):void
		{
			this.projs.launchProjectile(projectile);
		}
		
		public function landProjectile(projectile:Projectile):void
		{
			this.projs.landProjectile(projectile);
		}
		
	}

}