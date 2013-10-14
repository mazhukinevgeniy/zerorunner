package data 
{
	import data.structs.AchievementInfo;
	import data.structs.PreferencesInfo;
	import utils.updates.IUpdateDispatcher;
	
	public class DatabaseManager
	{
		
		
		public function DatabaseManager(flow:IUpdateDispatcher) 
		{
			
			//this._statistics = new StatisticSave(flow);
			//this._achievements = new AchievementSave();
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
			return new PreferencesInfo();
		}
	}

}