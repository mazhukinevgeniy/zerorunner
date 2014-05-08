package model.items.shard 
{
	import binding.IBinder;
	import model.items.Items;
	import model.items.MasterBase;
	import model.metric.CellXY;
	
	public class ShardMaster extends MasterBase
	{
		private var tmpCell:CellXY;
		
		public function ShardMaster(binder:IBinder, items:Items) 
		{
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.dropShard);
			
			super(elements);
			
			this.tmpCell = new CellXY(0, 0);
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.tmpCell.setValue(x, y);
			
			new Shard(this, this.elements, this.tmpCell);
		}
		
		update function dropShard(shard:Projectile):void
		{
			new Shard(this, this.elements, shard.cell);
		}
	}

}