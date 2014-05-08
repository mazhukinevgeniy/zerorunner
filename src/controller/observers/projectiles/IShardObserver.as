package controller.observers.projectiles 
{
	import model.projectiles.Projectile;
	
	public interface IShardObserver 
	{
		function shardIncoming(shard:Projectile):void;
	}
	
}