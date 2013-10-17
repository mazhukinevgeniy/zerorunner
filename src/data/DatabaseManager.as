package data 
{
	import data.structs.AchievementInfo;
	import data.structs.PreferencesInfo;
	import data.structs.StatisticsInfo;
	import data.updaters.*;
	import progress.achievements.AchievementSave;
	import progress.achievements.IAchievements;
	import utils.updates.IUpdateDispatcher;
	
	public class DatabaseManager
	{
		private var save:SharedObjectManager;
		
		private var _status:StatusReporter;
		
		public function DatabaseManager(flow:IUpdateDispatcher) 
		{
			this.save = new SharedObjectManager(flow);
			this._status = new StatusReporter(flow, this.save);
			
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
			return new StatisticsInfo(this.save.distance);
		}
		
		public function get status():StatusReporter
		{
			return this._status;
		}
		
		//TODO: remove this temporary thing
		public function get achievements():IAchievements
		{
			return new AchievementSave();
		}
	}

}