package game.utils.achievements 
{
	import game.utils.achievements.statistics.ActorStatistic;
	import game.utils.time.ICacher;
	import game.ZeroRunner;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class AchievementsFeature extends SaveBase implements ICacher
	{
		
		private var activeAchievements:Vector.<AchievementBase>;
		
		private var actorStat:ActorStatistic;
		
		public function AchievementsFeature(flow:IUpdateDispatcher) 
		{
			super();
			
			this.actorStat = new ActorStatistic(flow);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.unlockAchievement);
			
			flow.dispatchUpdate(Update.addCacher, this);
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