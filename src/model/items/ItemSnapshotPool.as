package model.items 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	
	internal class ItemSnapshotPool implements IGameFrameHandler
	{
		
		private var usedSnapshots:Vector.<ItemSnapshot>;
		private var freeSnapshots:Vector.<ItemSnapshot>;
		
		public function ItemSnapshotPool(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.usedSnapshots = new Vector.<ItemSnapshot>();
			this.freeSnapshots = new Vector.<ItemSnapshot>();
		}
		
		
		internal function getSnapshot():ItemSnapshot
		{
			var shot:ItemSnapshot = this.freeSnapshots.pop();
			
			if (!shot)
				shot = new ItemSnapshot();
			this.usedSnapshots.push(shot);
			
			return shot;
		}
		
		public function gameFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_RUN_CATACLYSM)
			{
				var shot:ItemSnapshot = this.usedSnapshots.pop();
				
				while (shot)
				{
					this.freeSnapshots.push(shot);
					shot = this.usedSnapshots.pop();
				}
			}
		}
	}

}