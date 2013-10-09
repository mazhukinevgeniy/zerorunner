package progress.statistics 
{
	import game.core.metric.DCellXY;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatisticSave extends SaveBase implements IStatistic
	{
		private static const totalDistance:String = "totalDistance";
		
		public function StatisticSave(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
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
		
		public function get namesOfStatistics():Vector.<String>
		{
			var names:Vector.<String> = new Vector.<String>;
			
			names.push(StatisticSave.totalDistance);
			
			return names;
		}
		
		public function get totalDistance():int
		{
			return this.localSave.data.statistics.actors.lifetime.distance;
		}
	}

}