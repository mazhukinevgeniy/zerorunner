package game.items.shard 
{
	import game.GameElements;
	import game.items.MasterBase;
	import game.projectiles.Projectile;
	import utils.updates.update;
	
	public class ShardMaster extends MasterBase
	{
		public function ShardMaster(elements:GameElements) 
		{
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.dropShard);
			
			super(elements);
		}
		
		override protected function gameStarted():void 
		{
			return;
		}
		
		update function dropShard(shard:Projectile):void
		{
			new Shard(this, this.elements, shard.cell);
		}
	}

}