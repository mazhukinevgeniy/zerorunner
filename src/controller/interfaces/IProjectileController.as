package controller.interfaces 
{
	import model.projectiles.Projectile;
	
	public interface IProjectileController 
	{
		function shardFell(shard:Projectile):void;
		
		function denyProjectile(projectile:Projectile):void;
	}
	
}