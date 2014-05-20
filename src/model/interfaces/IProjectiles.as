package model.interfaces 
{
	import model.projectiles.Projectile;
	
	public interface IProjectiles 
	{
		function getProjectile(cellId:int):Projectile;
	}
	
}