package game.items._utils 
{
	import game.GameElements;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.metric.ProtectedCellXY;
	import utils.updates.update;
	
	public class CheckpointMasterBase extends MasterBase
	{
		public static const ILLEGAL_CELL:ProtectedCellXY = new ProtectedCellXY( -1, -1);
		
		protected var tmpCell:CellXY = new CellXY( -1, -1);
		
		public function CheckpointMasterBase(elements:GameElements) 
		{
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
			
			super(elements);
		}
		
		
		
		final update function numberedFrame(frame:int):void
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