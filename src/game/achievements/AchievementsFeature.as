package game.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IStoreInformers;
	import chaotic.utils.SaveBase;
	import game.metric.DCellXY;
	import game.statistics.ITakeStatistics;
	import game.statistics.StatisticsFeature;
	import game.statistics.StatisticsPiece;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	
	public class AchievementsFeature extends SaveBase implements ICacher, IActorStatistic
	{
		private var activeAchievements:Vector.<AchievementBase>;
		
		
		public function AchievementsFeature(flow:IUpdateDispatcher) 
		{
			super();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(StatisticsFeature.emitStatistics);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			
			flow.dispatchUpdate(Time.addCacher, this);
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
			
			activeAchievements = new Vector.<AchievementBase>(); //TODO: actually implement
		}
		
		public function cache():void
		{
			var length:int = this.activeAchievements.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.activeAchievements[i].checkIfUnlocked(this.localSave.data);
			}
		}
		
		public function heroMoved(change:DCellXY):void
		{
			this.localSave.data.statistics.actors.lifetime.distance += change.length;
		}
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IActorStatistic, this);
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