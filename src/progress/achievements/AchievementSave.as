package progress.achievements 
{
	
	public class AchievementSave implements IAchievements
	{
		
		public function AchievementSave() 
		{
			
		}
		
		public function get numberOfAchievements():int
		{
			return 40;
		}
		
		public function getAchievement(id:int):AchievementData
		{
			return new AchievementData(id);
		}
	}

}