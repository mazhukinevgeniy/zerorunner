package model.items.shard 
{
	import binding.IBinder;
	import controller.observers.IShardObserver;
	import model.items.Items;
	import model.items.MasterBase;
	import model.metric.CellXY;
	import model.projectiles.Projectile;
	
	public class ShardMaster extends MasterBase implements IShardObserver
	{
		private var tmpCell:CellXY;
		
		public function ShardMaster(binder:IBinder, items:Items) 
		{
			binder.notifier.addObserver(this);
			
			super(binder, items);
			
			this.tmpCell = new CellXY(0, 0);
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.tmpCell.setValue(x, y);
			
			new Shard(this, this.tmpCell);
		}
		
		public function shardFellDown(shard:Projectile):void
		{
			new Shard(this, shard.cell);
		}
	}

}