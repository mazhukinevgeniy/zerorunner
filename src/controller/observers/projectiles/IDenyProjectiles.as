package controller.observers.projectiles 
{
	import model.projectiles.Projectile;
	
	public interface IDenyProjectiles 
	{
		function denyProjectile(projectile:Projectile):void;
		//TODO: consider deleting because absorbers don't need it
	}
	
}