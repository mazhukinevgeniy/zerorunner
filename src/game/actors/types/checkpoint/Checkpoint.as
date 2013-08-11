package game.actors.types.checkpoint 
{
	import game.actors.ActorsFeature;
	import game.actors.types.BroodmotherBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Checkpoint extends BroodmotherBase
	{
		private const STEPS_BETWEEN_CHECKPOINTS:int = 50;
		
		private var checkpoint:CheckpointLogic;
		
		private var center:ICoordinated;
		
		public function Checkpoint(flow:IUpdateDispatcher) 
		{
			super(null, null);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ZeroRunner.aftertick);
		}
		
		override protected function getActorsCap():int
		{
			return 0;
		}
		
		
		
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
			this.getActors().push(this.checkpoint = new CheckpointLogic());
			
			this.checkpoint.reset();
		}
		
		update function aftertick():void
		{
			if (Metric.distance(this.checkpoint, this.center) > this.STEPS_BETWEEN_CHECKPOINTS)
			{
				this.checkpoint.reset();
			}
		}
	}

}