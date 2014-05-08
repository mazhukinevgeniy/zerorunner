package view.shell.achievements.kind of logic of logic of logic 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	
	//TODO: find out what is this and implement it well
	public class AchievementViewer
	{
		private static const UNDEFINED:int = -1;
		
		private static const EDGES:Vector.<Point> = new <Point>[new Point(13, 5), new Point(13, 21), new Point(13, 12), new Point(9, 18), new Point(9, 17),
							   new Point(9, 16), new Point(9, 8), new Point(9, 1), new Point(9, 10), new Point(13, 14),
							   new Point(13, 22), new Point(13, 20), new Point(0, 1), new Point(1, 2), new Point(2, 3)];
		
		private var save:Dictionary;
		
		public function AchievementViewer(save:Dictionary) 
		{
			this.save = save;
		}
		
		public function get numberOfAchievements():int { return this.save["achievements"].length; }
		
		public function get edges():Vector.<Object>
		{
			return Vector.<Object>(this.save["achievementsEdge"]);
		}
		
		public function getAchievement(idOrIndex:int, isId:Boolean = true):Achievement
		{
			var achievementData:Vector.<Object>;
			var achievement:Achievement;
			
			if (isId)
			{
				var number:int = this.save["achievements"].length;
				for (var i:int = 0; i < number; ++i)
				{
					achievementData = this.save["achievements"][i];
					if (achievementData[0].x == idOrIndex)
						achievement = new Achievement(achievementData);
				}
			}
			else
			{
				achievementData = this.save["achievements"][idOrIndex];
				achievement = new Achievement(achievementData);
			}
				
			return achievement;
		}
	}

}