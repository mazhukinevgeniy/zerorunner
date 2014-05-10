package controller.interfaces 
{
	import model.projectiles.Projectile;
	
	public interface IProjectileController 
	{
		function shardFell(shard:Projectile):void;
	}
	
}