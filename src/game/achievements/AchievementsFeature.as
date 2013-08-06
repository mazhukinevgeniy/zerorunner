package game.achievements 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IStoreInformers;
	import chaotic.utils.SaveBase;
	import game.achievements.statistics.ActorStatistic;
	import game.achievements.statistics.IActorStatistic;
	import game.metric.DCellXY;
	import game.statistics.ITakeStatistics;
	import game.statistics.StatisticsFeature;
	import game.statistics.StatisticsPiece;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	
	public class AchievementsFeature extends SaveBase implements ICacher
	{
		public static const unlockAchievement:String = "unlockAchievement";
		
		
		private var activeAchievements:Vector.<AchievementBase>;
		
		private var actorStat:ActorStatistic;
		
		public function AchievementsFeature(flow:IUpdateDispatcher) 
		{
			super();
			
			this.actorStat = new ActorStatistic(flow);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(AchievementsFeature.unlockAchievement);
			
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		override protected function checkLocalSave():void
		{
			activeAchievements = new Vector.<AchievementBase>(); //TODO: actually implement
			
			//TODO: check if it's actually required to extend SaveBase here
		}
		
		public function cache():void
		{
			var length:int = this.activeAchievements.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.activeAchievements[i].checkIfUnlocked(this.localSave.data);
			}
		}
		
		
		update function unlockAchievement(id:int):void
		{
			// TODO: do stuff and, if required, refill your activeAchievements vector
			
			//TODO: also add some feature to show pop-up with the heartwarming notify
		}
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IActorStatistic, this.actorStat);
		}
	}

}