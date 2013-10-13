package progress.achievements 
{
	import flash.geom.Point;
	
	public class AchievementSave implements IAchievements
	{
		
		public function AchievementSave() 
		{
			
		}
		
		public function get numberOfAchievements():int
		{
			return 40;
		}
		
		public function get edges():Vector.<Point>
		{
			return new <Point>[new Point(0, 1), new Point(1, 2), new Point(2, 3)];
		}
		
		public function getAchievement(id:int):AchievementData
		{
			return new AchievementData(id);
		}
	}

}