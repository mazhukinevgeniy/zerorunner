package data 
{
	
	public class SaveManager //TODO: rename
	{
		
		
		public function SaveManager(flow:IUpdateDispatcher) 
		{
			
			this._statistics = new StatisticSave(flow);
			this._achievements = new AchievementSave();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
		}
		
		
		
		public function get numberOfAchievements():int
		{
			return 0;
		}
		
		public function getAchievement(id:int):AchievementInfo
		{
			return new AchievementInfo();
		}
	}

}