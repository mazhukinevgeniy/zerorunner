package model.interfaces 
{
	import model.projectiles.Projectile;
	
	public interface IProjectiles 
	{
		function getProjectile(x:int, y:int):Projectile;
	}
	
}