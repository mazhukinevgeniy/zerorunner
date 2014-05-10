package controller.observers 
{
	import model.projectiles.Projectile;
	
	public interface IShardObserver 
	{
		function shardFellDown(shard:Projectile):void;
	}
	
}