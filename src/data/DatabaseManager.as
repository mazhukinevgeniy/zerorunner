package data 
{
	import data.updaters.*;
	import data.viewers.AchievementViewer;
	import data.viewers.GameConfig;
	import data.viewers.PreferencesViewer;
	import data.viewers.StatisticsViewer;
	import utils.updates.IUpdateDispatcher;
	
	public class DatabaseManager
	{
		private var save:SharedObjectManager;
		
		private var _preferences:PreferencesViewer;
		private var _achievements:AchievementViewer;
		private var _statistics:StatisticsViewer;
		private var _config:GameConfig;
		
		private var _status:StatusReporter;
		
		public function DatabaseManager(flow:IUpdateDispatcher) 
		{
			this.save = new SharedObjectManager(flow);
			
			this._status = new StatusReporter(flow, this.save);
			
			this._preferences = new PreferencesViewer(this.save);
			this._achievements = new AchievementViewer();
			this._statistics = new StatisticsViewer(this.save);
			this._config = new GameConfig(this.save);
			
			new AchievementsUpdater(flow, this.save);
			new PreferencesUpdater(flow, this.save);
			new ProgressUpdater(flow, this.save);
			new StatisticsUpdater(flow, this.save);
		}
		
		
		
		public function get preferences():PreferencesViewer { return this._preferences; }
		public function get statistics():StatisticsViewer { return this._statistics; }
		public function get status():StatusReporter { return this._status; }
		public function get achievements():AchievementViewer { return this._achievements; }
		public function get config():GameConfig { return this._config; }
	}

}