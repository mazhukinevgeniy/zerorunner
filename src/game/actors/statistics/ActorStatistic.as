package game.actors.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.utils.SaveBase;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.statistics.ITakeStatistics;
	import game.statistics.StatisticsFeature;
	import game.statistics.StatisticsPiece;
	
	public class ActorStatistic extends SaveBase implements IActorStatistic
	{
		
		public function ActorStatistic(flow:IUpdateDispatcher) 
		{
			super();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(StatisticsFeature.emitStatistics);
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
		
		public function heroMoved(change:DCellXY):void
		{
			this.localSave.data.statistics.actors.lifetime.distance += change.length;
		}
		
		
		public function emitStatistics(requester:ITakeStatistics):void
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