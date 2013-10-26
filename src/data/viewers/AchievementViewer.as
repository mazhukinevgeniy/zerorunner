package data.viewers 
{
	import flash.geom.Point;
	import flash.utils.Proxy;
	
	public class AchievementViewer
	{
		
		private var save:Proxy;
		
		public function AchievementViewer(save:Proxy) 
		{
			this.save = save;
		}
		
		public function get numberOfAchievements():int { return this.save["numberOfAchievements"]; }
		
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