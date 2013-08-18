package game.utils.achievements.statistics 
{
	import game.utils.metric.DCellXY;
	import game.utils.statistics.ITakeStatistics;
	import game.utils.statistics.StatisticsPiece;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ActorStatistic extends SaveBase
	{
		
		public function ActorStatistic(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.emitStatistics);
			flow.addUpdateListener(Update.moveCenter);
		}
		
		override protected function checkLocalSave():void
		{
			if (!this.localSave.data.statistics)
				this.localSave.data.statistics = new Object();
			
			if (!this.localSave.data.statistics.actors)
			{
				this.localSave.data.statistics.actors = new Object();
				
				var lifetime:Object = new Object();
				lifetime.distance = 0;
				
				this.localSave.data.statistics.actors.lifetime = lifetime;
			}
		}
		
		
		update function moveCenter(change:DCellXY, delay:int):void
		{
			this.localSave.data.statistics.actors.lifetime.distance += change.length;
		}
		
		update function emitStatistics(requester:ITakeStatistics):void
		{
			var vector:Vector.<String> = new <String>
				[
					"lifetime distance: " + this.localSave.data.statistics.actors.lifetime.distance,
					"so it goes"
				]
			
			requester.takeStatistics(new StatisticsPiece(vector));
		}
	}

}