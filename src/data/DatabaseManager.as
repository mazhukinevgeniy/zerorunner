package data 
{
	import data.structs.AchievementInfo;
	import data.structs.PreferencesInfo;
	import data.structs.StatisticsInfo;
	import utils.updates.IUpdateDispatcher;
	
	public class DatabaseManager
	{
		private var save:SharedObjectManager;
		
		
		public function DatabaseManager(flow:IUpdateDispatcher) 
		{
			this.save = new SharedObjectManager();
			
			new AchievementsUpdater(flow, this.save);
			new PreferencesUpdater(flow, this.save);
			new ProgressUpdater(flow, this.save);
			new StatisticsUpdater(flow, this.save);
		}
		
		
		
		public function get numberOfAchievements():int
		{
			return 0;
		}
		
		public function getAchievement(id:int):AchievementInfo
		{
			return new AchievementInfo();
		}
		
		public function get preferences():PreferencesInfo
		{
			return new PreferencesInfo(this.save.mute);
		}
		
		public function get statistics():StatisticsInfo
		{
			return new StatisticsInfo(0);//TODO: implement better
		}
	}

}