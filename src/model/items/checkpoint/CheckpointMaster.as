package model.items.checkpoint 
{
	import binding.IBinder;
	import model.items._utils.CheckpointMasterBase;
	import model.items.Items;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	import model.projectiles.Projectile;
	
	public class CheckpointMaster extends CheckpointMasterBase
	{
		
		private var checkpoints:Vector.<Checkpoint>;
		
		public function CheckpointMaster(binder:IBinder, items:Items) 
		{			
			super(binder, items);
			
			this.checkpoints = new Vector.<Checkpoint>();
		}
		
		override protected function onGameFinished():void 
		{
			this.checkpoints.length = 0;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.checkpoints.push(
				new Checkpoint(this, new CellXY(x, y)));
		}
		
		override protected function getReachedCheckpoint():ICoordinated 
		{
			
			return CheckpointMasterBase.ILLEGAL_CELL;
		}
		
		override protected function activateCheckpoint(place:ICoordinated):void 
		{
			throw new Error("design undefined");
			
			//TODO: empower checkpoints, make them more meaningful
		}
	}

}