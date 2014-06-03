package model.items 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.interfaces.IItemSnapshotter;
	import model.items.concrete.ItemSpawner;
	import model.projectiles.Projectile;
	import model.status.StatusReporter;
	import starling.events.Event;
	import utils.getCellId;
	
	/**
	 * This class manages interaction between Items and the other modules
	 */
	public class Items
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
			
			binder.eventDispatcher.addEventListener(GlobalEvent.PROJECTILE_FELL, this.projectileFell);
		}
		
		
		private function projectileFell(event:Event, proj:Projectile):void
		{
			var cellId:int = getCellId(proj.cell.x, proj.cell.y);
			
			if (proj.type == Game.PROJECTILE_SHARD)
			{
				var itemHit:ItemBase = this.storage.getItem(cellId);
				
				if (itemHit)
				{
					itemHit.tryDestruction();
				}
				else
				{
					this.spawner.createShard(proj.cell.x, proj.cell.y);
				}
			}
			
		}
	}

}