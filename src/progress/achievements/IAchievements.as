package progress.achievements 
{
	
	public interface IAchievements 
	{
		function get numberOfAchievements():int;
		
		function getAchievement(id:int):AchievementData;
	}
	
}