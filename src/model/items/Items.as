package model.items 
{
	import binding.IBinder;
	import controller.observers.IShardObserver;
	import model.interfaces.IItemSnapshotter;
	import model.items.concrete.ItemSpawner;
	import model.projectiles.Projectile;
	import model.status.StatusReporter;
	import utils.getCellId;
	
	/**
	 * This class manages interaction between Items and the other modules
	 */
	public class Items implements IShardObserver
	{
		internal var storage:ItemStorage;
		internal var notifier:ItemNotifier;
		internal var spawner:ItemSpawner;
		
		public function Items(binder:IBinder, status:StatusReporter) 
		{
			this.storage = new ItemStorage(binder);
			this.notifier = new ItemNotifier(binder);
			this.spawner = new ItemSpawner(binder, this, status);
			
			binder.addBindable(new ItemSnapshotter(this.storage, binder), 
			                   IItemSnapshotter);
			binder.notifier.addObserver(this);
		}
		
		
		public function shardFellDown(shard:Projectile):void
		{
			var cellId:int = getCellId(shard.cell.x, shard.cell.y);
			
			var itemHit:ItemBase = this.storage.getItem(cellId);
			
			
			if (itemHit)
			{
				itemHit.tryDestruction();
			}
			else
			{
				this.spawner.createShard(shard.cell.x, shard.cell.y);
			}
		}
	}

}