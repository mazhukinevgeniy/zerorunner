package data 
{
	import data.structs.AchievementSave;
	import data.structs.StatisticsInfo;
	import data.updaters.*;
	import data.viewers.PreferencesViewer;
	import utils.updates.IUpdateDispatcher;
	
	public class DatabaseManager
	{
		private var save:SharedObjectManager;
		
		private var _preferences:PreferencesViewer;
		
		private var _status:StatusReporter;
		
		public function DatabaseManager(flow:IUpdateDispatcher) 
		{
			this.save = new SharedObjectManager(flow);
			this._status = new StatusReporter(flow, this.save);
			
			this._preferences = new PreferencesViewer(this.save);
			
			new AchievementsUpdater(flow, this.save);
			new PreferencesUpdater(flow, this.save);
			new ProgressUpdater(flow, this.save);
			new StatisticsUpdater(flow, this.save);
		}
		
		
		
		public function get preferences():PreferencesViewer
		{
			return this._preferences;
		}
		
		public function get statistics():StatisticsInfo
		{
			return new StatisticsInfo(this.save.distance);
		}
		
		public function get status():StatusReporter
		{
			return this._status;
		}
		
		//TODO: update it just as everything else gets redesigned
		public function get achievements():AchievementSave
		{
			return new AchievementSave();
		}
	}

}