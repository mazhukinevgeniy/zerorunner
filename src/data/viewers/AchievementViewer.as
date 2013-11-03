package data.viewers 
{
	import flash.geom.Point;
	import flash.utils.Proxy;
	import ui.windows.achievements.Achievement;
	
	public class AchievementViewer
	{
		private var save:Proxy;
		
		private static const EDGES:Vector.<Point> = new <Point>[new Point(13, 5), new Point(13, 21), new Point(13, 12), new Point(9, 18), new Point(9, 17),
							   new Point(9, 16), new Point(9, 8), new Point(9, 1), new Point(9, 10), new Point(13, 14),
							   new Point(13, 22), new Point(13, 20), new Point(0, 1), new Point(1, 2), new Point(2, 3)];
		
		public function AchievementViewer(save:Proxy) 
		{
			this.save = save;
		}
		
		public function get numberOfAchievements():int { return this.save["achievements"].length; }
		
		public function get edges():Vector.<Point>
		{
			return AchievementViewer.EDGES;
		}
		
		public function getAchievement(id:int):Achievement
		{
			var number:int = this.save["achievements"].length;
			var achievementData:Vector.<Object>;
			var achievement:Achievement;
			
			for (var i:int = 0; i < number; ++i)
			{
				achievementData = this.save["achievements"][i];
				if (achievementData[0].x == id)
					achievement = new Achievement(achievementData);
			}
			return achievement;
		}
		//TODO: impelement the way to give suitable save-based amount of information
	}

}