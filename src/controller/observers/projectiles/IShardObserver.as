package controller.observers.projectiles 
{
	import model.projectiles.Projectile;
	
	public interface IShardObserver 
	{
		function shardFellDown(shard:Projectile):void;
	}
	
}