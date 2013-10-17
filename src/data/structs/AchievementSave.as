package data.structs 
{
	import flash.geom.Point;
	
	public class AchievementSave
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
			return new <Point>[new Point(13, 5), new Point(13, 21), new Point(13, 12), new Point(9, 18), new Point(9, 17),
							   new Point(9, 16), new Point(9, 8), new Point(9, 1), new Point(9, 10), new Point(13, 14),
							   new Point(13, 22), new Point(13, 20), new Point(0, 1), new Point(1, 2), new Point(2, 3)];
		}
		
		//public function getAchievement(id:int)
		//TODO: impelement the way to give suitable save-based amount of information
	}

}