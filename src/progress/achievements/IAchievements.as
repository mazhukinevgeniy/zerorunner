package progress.achievements 
{
	import flash.geom.Point;
	
	public interface IAchievements 
	{
		function get numberOfAchievements():int;
		
		function get edges():Vector.<Point>;
		
		function getAchievement(id:int):AchievementData;
	}
	
}