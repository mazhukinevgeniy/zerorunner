package game.items.shard 
{
	import game.GameElements;
	import game.items.MasterBase;
	import game.projectiles.Projectile;
	import utils.updates.update;
	
	public class ShardMaster extends MasterBase
	{
		private var elements:GameElements;
		
		public function ShardMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.dropShard);
		}
		
		update function dropShard(shard:Projectile):void
		{
			new Shard(this, this.elements, shard.cell);
		}
	}

}