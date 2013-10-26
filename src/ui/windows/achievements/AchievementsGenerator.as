package ui.windows.achievements 
{
	import flash.geom.Point;
	import utils.updates.IUpdateDispatcher;
	
	public class AchievementsGenerator 
	{	
		private var flow:IUpdateDispatcher;
		
		public function AchievementsGenerator(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
		}
		
		public function createAchievement():void
		{
			var data:Vector.<Point>;
			var type:int = 0;
			var condition:int = 20;
			
			data = new <Point>[new Point(type, condition)];
			
			this.flow.dispatchUpdate(Update.createAchievements, data);
		}
		
	}

}