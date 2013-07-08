package model 
{
	import chaotic.core.IGame;
	import model.settings.ISettings;
	import model.settings.Settings;
	import model.statistics.IKnowAchievements;
	import model.statistics.IKnowStatistics;
	import model.statistics.Statistic;
	
	public class Data implements IModel
	{
		private var statistic:Statistic;
		
		private var _settings:Settings;
		
		private var game:IGame;
		
		public function Data(item:IGame)
		{
			this.game = item;
			
			this.statistic = new Statistic();
			
			this._settings = new Settings();
		}
		
		public function getSettings():ISettings { return this._settings; }
		public function get settings():ISettings { return this._settings; }
	}

}