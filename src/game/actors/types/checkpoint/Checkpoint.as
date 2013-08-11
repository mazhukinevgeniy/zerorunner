package game.actors.types.checkpoint 
{
	import game.actors.ActorsFeature;
	import game.actors.types.BroodmotherBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ZeroRunner;
	
	public class Checkpoint extends BroodmotherBase
	{
		private const STEPS_BETWEEN_CHECKPOINTS:int = 200;
		
		private var lastCheckpoint:CellXY;
		private var cellHelper:CellXY;
		
		private var searcher:ISearcher;
		
		public function Checkpoint(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(ActorsFeature.moveCenter);
			
			this.lastCheckpoint = new CellXY(0, 0);
			this.cellHelper = new CellXY(0, 0);
		}
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			this.searcher = table.getInformer(ISearcher);
		}
		
		update function prerestore():void
		{
			var spawn:CellXY = ActorsFeature.SPAWN_CELL;
			
			this.lastCheckpoint.setValue(spawn.x - this.STEPS_BETWEEN_CHECKPOINTS, spawn.y - this.STEPS_BETWEEN_CHECKPOINTS);
		}
		
		update function moveCenter(change:DCellXY, delay:int):void
		{
			this.searcher.getCharacterCell(this.cellHelper);
			
			if (Metric.distance(this.cellHelper, this.lastCheckpoint) > this.STEPS_BETWEEN_CHECKPOINTS)
			{
				//TODO: add checkpoint
			}
		}
	}

}