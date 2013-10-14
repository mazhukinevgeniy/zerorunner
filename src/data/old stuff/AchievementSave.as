package data.old stuff 
{
	
	public class AchievementSave implements IAchievements
	{
		
		public function AchievementSave() 
		{
			
		}
		
		public function get numberOfAchievements():int
		{
			return 0;
		}
		
		public function getAchievement(id:int):AchievementData
		{
			return new AchievementData();
		}
	}

}