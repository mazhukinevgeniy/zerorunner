package game.achievements 
{
	import game.achievements.statistics.ActorStatistic;
	import game.core.time.ICacher;
	import game.core.time.Time;
	import game.statistics.ITakeStatistics;
	import game.statistics.StatisticsFeature;
	import game.statistics.StatisticsPiece;
	import game.ZeroRunner;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
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
			flow.addUpdateListener(AchievementsFeature.unlockAchievement);
			
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		override protected function checkLocalSave():void
		{
			activeAchievements = new Vector.<AchievementBase>();
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
			
		}
	}

}