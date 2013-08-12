package game.actors.types.checkpoint 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.utils.ConfigKit;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	
	internal class CheckpointLogic extends ActorLogicBase
	{
		private const STEPS_BETWEEN_CHECKPOINTS:int = 20;
		
		public function CheckpointLogic() 
		{
			super(new CheckpointView());
		}
		
		override protected function getSpawningCell():CellXY
		{
			var center:ICoordinated = this.world.getCenter();
			
			for (var i:int = 2; i < 6; i++)
				for (var j:int = 2; j < 6; j++)
				{
					if (!this.world.findObjectByCell(center.x + i, center.y + j))
						return new CellXY(center.x + i, center.y + j);
				}
			throw new Error();
			
			//TODO: implement better
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