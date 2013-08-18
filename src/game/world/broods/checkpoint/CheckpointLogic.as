package game.world.broods.checkpoint 
{
	import game.utils.metric.CellXY;
	import game.utils.metric.ICoordinated;
	import game.utils.metric.Metric;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.ConfigKit;
	
	internal class CheckpointLogic extends ItemLogicBase
	{
		private const STEPS_BETWEEN_CHECKPOINTS:int = 20;
		
		public function CheckpointLogic() 
		{
			super(new CheckpointView());
		}
		
		override protected function getSpawningCell():CellXY
		{
			var center:ICoordinated = this.world.getCenter();
			
			var dX:int = 2 + Math.random() * 4; dX *= Math.random() < 0.5 ? 1 : -1;
			var dY:int = 2 + Math.random() * 4; dY *= Math.random() < 0.5 ? 1 : -1;
			
			var tmpCell:CellXY = Metric.getTmpCell(center.x + dX, center.y + dY);
			
			var actor:ItemLogicBase = this.world.findObjectByCell(tmpCell.x, tmpCell.y);
			
			if (actor)
				actor.applyDestruction();
			
			return tmpCell;
		}
		
		override protected function getConfig():ConfigKit
		{
			return new ConfigKit(10000000, 10000000, 10000000);
		}
		
		override protected function onCanAct():void
		{
			if (Metric.distance(this, this.world.getCenter()) > this.STEPS_BETWEEN_CHECKPOINTS)
			{
				this.reset();
			}
		}
	}

}