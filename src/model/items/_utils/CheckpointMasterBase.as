package model.items._utils 
{
	import binding.IBinder;
	import controller.observers.game.IGameFrameHandler;
	import model.items.Items;
	import model.items.MasterBase;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	import model.metric.ProtectedCellXY;
	
	public class CheckpointMasterBase extends MasterBase implements IGameFrameHandler
	{
		public static const ILLEGAL_CELL:ProtectedCellXY = new ProtectedCellXY( -1, -1);
		
		protected var tmpCell:CellXY = new CellXY( -1, -1);
		
		public function CheckpointMasterBase(binder:IBinder, items:Items) 
		{
			super(binder, items);
		}
		
		
		
		public function gameFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT)
			{
				var found:ICoordinated = this.getReachedCheckpoint();
				
				if (!CheckpointMasterBase.ILLEGAL_CELL.isEqualTo(found))
				{
					this.activateCheckpoint(found);
				}
			}
		}
		
		protected function getReachedCheckpoint():ICoordinated
		{
			throw new Error("must implement");
		}
		
		protected function activateCheckpoint(place:ICoordinated):void
		{
			throw new Error("must implement");
		}
	}

}