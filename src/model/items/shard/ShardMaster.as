package model.items.shard 
{
	import game.GameElements;
	import game.items.MasterBase;
	import game.metric.CellXY;
	import game.projectiles.Projectile;
	import utils.updates.update;
	
	public class ShardMaster extends MasterBase
	{
		private var tmpCell:CellXY;
		
		public function ShardMaster(elements:GameElements) 
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